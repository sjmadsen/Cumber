require 'json'
require 'uri'
require 'net/http'
require 'cumber/imports'

##
# Cumber is an automated testing tool that bridges the gap between cucumber tests and the Apple automated testing tools
# UI Automation provided with XCode and Instruments.
module Cumber

  @host = 'localhost'
  @port = '8080'

  ##
  # Creates an instance of a Cumber Element to use as a base to query UI Automation.
  #
  # ==== Parameters
  #
  # * +step+ - A string that represents the javascript call to execute in UI Automation.
  #
  # ==== Examples
  #
  #   result = Cumber.execute_step('target.logElementTree()')

  def self.execute_step(step)
    response = send_command(step)
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
  #   result = Cumber.parse_response('{"message":"test"}')

  def self.parse_response(response)
    response_json = JSON.parse(response)
    return response_json['message']
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
  #   result = Cumber.send_command('frontApp.keyboard().typeString("password")')

  def self.send_command(command)

    request = Net::HTTP::Post.new('/cumber', initheader = {'Content-Type' => 'application/json'})
    request.body = format_command(command)

    response = Net::HTTP.start(@host, @port) do |http|
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
  #   result = Cumber.format_command('frontApp.keyboard().typeString("password")')

  def self.format_command(command)
    return '{"message":"' + strip_special_chars(command) + '"}'
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
  #   result = Cumber.strip_special_chars('frontApp.keyboard().typeString("password")')

  def self.strip_special_chars(command)
    command.gsub!('&', '&38;')
    command.gsub!('[', '&91;')
    command.gsub!(']', '&93;')
    command.gsub!('"', '&34;')
    command.gsub!(' ', '&32;')
    command.gsub!('{', '&123;')
    command.gsub!('}', '&125;')

    return command
  end

end