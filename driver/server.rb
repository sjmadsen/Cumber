require 'socket'
require 'json'

HOST = 'localhost'
PORT = 8080
@cmd = ''
@rsp = ''

def self.main

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
    response = '{"message":"' + self.wait_for_response + '"}'

  elsif request == '/device'
    self.set_response(message)
    response = '{"message":"' + self.wait_for_command + '"}'
  end

  return response
end

def self.set_command(message)
  message_json = JSON.parse(message)
  @cmd = message_json['message']
  STDERR.puts 'Received Command: ' + @cmd + "\n"
end

def self.set_response(message)
  message_json = JSON.parse(message)
  @rsp = message_json['message']
  STDERR.puts 'Received Response: ' + @rsp + "\n"
end

def self.wait_for_command

  while @cmd.length == 0
  end

  command = @cmd
  STDERR.puts 'Sending Command: ' + command + "\n"
  @cmd = ''

  command
end

def self.wait_for_response

  while @rsp.length == 0
  end

  response = @rsp
  STDERR.puts 'Sending Response: ' + response + "\n"
  @rsp = ''

  response
end

main
