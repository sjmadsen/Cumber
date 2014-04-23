require 'json'
require 'uri'
require 'net/http'
require 'cumber/imports'
require 'fileutils'

##
# Cumber is an automated testing tool that bridges the gap between cucumber tests and the Apple automated testing tools
# UI Automation provided with XCode and Instruments.
#

module Cumber

  @host = 'localhost'
  @port = '8080'
  @server_process

  ##
  # Creates an instance of a Cumber Element to use as a base to query UI Automation.
  #
  # ==== Parameters
  #
  # * +step+ - A string that represents the javascript call to execute in UI Automation.
  #
  # ==== Examples
  #
  #   Cumber.execute_step('target.mainWindow.size()') #=> returns the result of the command

  def self.execute_step(step)
    response = send_command(step, 'run')
    response = parse_response(response)

    return response
  end

  ##
  # Parses through the response from send_command and returns the portion of the resulting value of the executed ruby
  # command.
  #
  # ==== Parameters
  #
  # * +response+ - The json response from UI Automation.
  #
  # ==== Examples
  #
  #   Cumber.parse_response('{"message":"test"}') #=> returns 'test'

  def self.parse_response(response)
    response_json = JSON.parse(response)
    response_json
  end

  ##
  # Formats and sends the string query to UI Automation. and returns the response
  #
  # ==== Parameters
  #
  # * +command+ - The string query to send to UI Automation.
  #
  # ==== Examples
  #
  #   Cumber.send_command('frontApp.keyboard().typeString("password")') #=> returns '{"message":"response"}'

  def self.send_command(command, status)

    request = Net::HTTP::Post.new('/cumber', initheader = {'Content-Type' => 'application/json'})
    request.body = format_command(command, status)

    response = Net::HTTP.start(@host, @port, :read_timeout => 2000000) do |http|
      http.request(request)
    end

    return response.body

  end

  ##
  # Formats the string query that will be sent to UI Automation.
  #
  # ==== Parameters
  #
  # * +command+ - The string query to send to UI Automation.
  #
  # ==== Examples
  #
  #   Cumber.format_command('frontApp.keyboard().typeString("password")') #=> returns '{"message":"target.frontMostApp().keyboard().typeString(&34;password&34;);"}'

  def self.format_command(command, status)
    return '{"message":"' + strip_special_chars(command) + '", "status":"' + status + '"}'
  end

  ##
  # Replaces special characters in the string query with modified HTML codes for the characters '&', '[', ']', '"', ' ',
  # '{', and '}'.
  #
  # ==== Parameters
  #
  # * +command+ - The string query to send to UI Automation.
  #
  # ==== Examples
  #
  #   Cumber.strip_special_chars('frontApp.keyboard().typeString("password")') #=> returns 'target.frontMostApp().keyboard().typeString(&34;password&34;)'

  def self.strip_special_chars(command)
    command.gsub!("'", "\\\\'")
    command.gsub!('"', '\"')

    return command
  end

  ##
  # Starts the Cumber Server. Needs to be called once at the begging of a Cucumber run. <br>
  #
  # ==== Examples
  #   #Place in your env.rb file.
  #   Cumber.start

  def self.start(debug = false)

    stop_server

    @server_process = Process.fork do
      CumberServer.start(debug)
    end

  end

  ##
  # Stops the Cumber Server and the current instruments run. Needs to be called at the end of a Cucumber run. <br>
  #
  # ==== Examples
  #   #Place in your env.rb file.
  #
  #   at_exit do
  #     Cumber.stop
  #   end
  #

  def self.stop
    stop_instruments
    stop_server
  end

  ##
  # Stops the Cumber Server <br>
  #
  # ==== Examples
  #
  #     Cumber.stop_server
  #

  def self.stop_server
    server_pid = %x[lsof -t -i TCP:8080]
    pids = server_pid.split("\n")

    pids.each do |pid|
      system('kill -3 ' + pid)
    end

  end

  ##
  # Closes the app and prepares the tablet for the next scenario. Stops instruments, cleans up the trace file and reloads instruments in a new thread.
  #
  # ==== Parameters
  #
  # * +udid+ - The unique identifier of the iOS Device to run tests against.
  # * +target+ - The name of the app to launch when cumber starts.
  #
  # ==== Examples
  #   #Place in your hooks.rb file.
  #
  #   Before() do
  #     Cumber.new_run(23123sasd12321313..., Cumber-Test)
  #   end
  #

  def self.new_run(udid, target)

    stop_instruments
    system('rm -rf ./bin/ins.trace')
    system('rm -rf ./bin/logs')
    system('mkdir ./bin/logs')

    Thread.new do
      start_instruments(udid, target)
    end

  end

  ##
  # Starts instruments
  #
  # ==== Parameters
  #
  # * +udid+ - The unique identifier of the iOS Device to run tests against.
  # * +target+ - The name of the app to launch when cumber starts.
  #
  # ==== Examples
  #
  #     Cumber.start_instruments(Cumber-Test, 23123sasd12321313...)
  #

  def self.start_instruments(udid, target)
    driver_path = path_to_driver + '/driver.js'
    command = 'instruments -w '+ udid +' -D ./bin/ins -t /Applications/Xcode.app/Contents/Applications/Instruments.app/Contents/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate '+ target +' -e UIASCRIPT ' + driver_path + ' -e UIARESULTSPATH ./bin/logs'
    result = %x[#{command}]

    if result.include?('Known Devices:')
      puts 'Instruments Failed to start attempting to start again'
      system('pkill -9 -f instruments')
      start_instruments(udid, target)

    else
      result
    end

  end

  ##
  # Stops instruments before starting a new run. <br>
  #
  # ==== Examples
  #
  #   Cumber.stop_instruments
  #
  def self.stop_instruments
    send_command('', 'end')
    system('pkill -9 -f instruments')
  end

  ##
  # Returns the path to the Cumber instruments driver file. <br>
  #
  # ==== Examples
  #
  #   Cumber.path_to_driver
  #

  def self.path_to_driver
    File.join(File.dirname(File.expand_path(__FILE__)), 'cumber/driver')
  end

  ##
  # Generates meta data to be used when inspecting the Elements on the screen. Generates json file for element meta data and takes a screenshot
  #

  def self.inspect
    puts 'Getting elements this may take a min...'
    json_data = Cumber::Element.new(:ancestry => 'target').element_tree
    file_location = Cumber::Device.new().screenshot
    json_location = File.dirname(file_location) + '/data.txt'
    File.open(json_location, 'w+') {|f| f.write(json_data) }
  end

end