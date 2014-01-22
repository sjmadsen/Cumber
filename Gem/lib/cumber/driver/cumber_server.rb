require 'socket'
require 'json'

##
# Manages communication between UI Instruments and the Cumber Gem.
#
class CumberServer

  HOST = 'localhost'
  PORT = 8080
  @cmd = ''
  @rsp = ''

  def self.start

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

  def self.set_command(message)
    @cmd = message
    log('Received Command: ' + @cmd)

    message_json = JSON.parse(message)

    if message_json['status'] == 'end'
      @cmd = 'break;'
      @rsp = '{"message":"end", "status":"closing"}'
    end
  end

  def self.set_response(message)
    message_json = JSON.parse(message)

    log('Received Response: ' + message)

    if message_json['status'] != 'connecting'
      @rsp = message
    end

  end

  def self.wait_for_command

    while @cmd.length == 0
    end

    command = @cmd
    log('Sending Command: ' + command)
    @cmd = ''

    command
  end

  def self.wait_for_response

    while @rsp.length == 0
    end

    response = @rsp
    log('Sending Response: ' + response)
    @rsp = ''

    response
  end

  def self.log (message)
    #puts message + "\n"
  end

end