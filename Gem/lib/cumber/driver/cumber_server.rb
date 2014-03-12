require 'socket'
require 'json'

$0 ="CumberServer\0"
##
# Manages communication between UI Instruments and the Cumber Gem.
#
class CumberServer
  ##
  # The host socket to run the server on
  HOST = 'localhost'


  ##
  # The host port to run the server on
  PORT = 8080
  @cmd = ''
  @rsp = ''
  @debug = false

  ##
  # Starts the running Cumber server on localhost:8080.
  #
  # ==== Optional Parameters
  #
  # * +debug+ - Turns on logging for the server. Defaults to false.
  #
  # ====Examples
  #   CumberServer.start
  #

  def self.start (debug = false)

    @debug = debug
    server = TCPServer.new('localhost', 8080)
    puts "Server listening on: #{HOST}:#{PORT}"

    loop do

      Thread.start(server.accept) do |socket|
        request = socket.gets
        user_agent = socket.gets
        host = socket.gets
        accept = socket.gets
        content_type = socket.gets
        content_size = socket.gets.split(" ")[1].to_i
        line_break = socket.gets
        message = socket.read(content_size)
        response = generate_response(request, message)

        socket.print "HTTP/1.1 200 OK\r\n" +
                         "Content-Type: text/plain\r\n" +
                         "Content-Length: #{response.bytesize}\r\n" +
                         "Connection: close\r\n"

        socket.print "\r\n"

        socket.print response
        socket.close

      end
    end

  end

  ##
  # Processes the Json data from the client request and returns the proper response.
  #
  # ====Examples
  #   CumberServer.generate_response('/device', '{"message":"", "status":""}')
  #
  def self.generate_response(client, message)

    request = client.split(' ')[1]

    response = ''

    if request == '/cumber'
      self.set_command(message)
      response = self.wait_for_response

    elsif request == '/device'
      self.set_response(message)
      response = self.wait_for_command
    end

    return response
  end

  ##
  # Processes the data response from the Cumber Gem client.
  #
  # ====Examples
  #   CumberServer.set_command('{"message":"", "status":""}')
  #
  def self.set_command(message)
    @cmd = message
    log('Received Command: ' + @cmd)

    message_json = JSON.parse(message)

    if message_json['status'] == 'end'
      @cmd = 'break;'
      @rsp = '{"message":"end", "status":"closing"}'
    end
  end

  ##
  # Processes the data response from the instruments driver client.
  #
  # ====Examples
  #   CumberServer.set_response('{"message":"", "status":""}')
  #
  def self.set_response(message)
    log('Received Response: ' + message)

    message_json = JSON.parse(message)

    log('Received Response: ' + message)

    if message_json['status'] != 'connecting'
      @rsp = message
    end

  end

  ##
  # Delays the response to the device until a command comes in.
  #
  # ====Examples
  #   CumberServer.wait_for_command
  #
  def self.wait_for_command

    while @cmd.length == 0
    end

    command = @cmd
    log('Sending Command: ' + command)
    @cmd = ''

    command
  end

  ##
  # Delays the response to the cumber gem client until a response comes in.
  #
  # ====Examples
  #   CumberServer.wait_for_response
  #
  def self.wait_for_response

    while @rsp.length == 0
    end

    response = @rsp
    log('Sending Response: ' + response)
    @rsp = ''

    response
  end

  ##
  # Logs information for debug mode. Pass in true when starting the server for debug mode.
  #
  # ====Examples
  #   CumberServer.log("")
  #
  def self.log (message)

    if @debug
      puts message + "\n"
    end
  end

end