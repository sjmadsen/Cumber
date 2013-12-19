require 'json'
require 'uri'
require 'net/http'

class Cumber
 @host = 'localhost'
 @port = '8080'

  def self.execute_step(step)
    response = send_command(step)
    response = parse_response(response)

    return response
  end

  def self.parse_response(response)
    response_json = JSON.parse(response)
    return response_json['message']
  end

  private

  def self.send_command(command)

    req = Net::HTTP::Post.new('/cumber', initheader = {'Content-Type' =>'application/json'})
    req.body = format_command(command)

    response = Net::HTTP.new(@host, @port).start {|http| http.request(req) }

    puts "Response #{response.code} #{response.message}: #{response.body}"

    return response.body
  end

  def self.format_command(command)
    return '{"message":"' + strip_special_chars(command) + '"}'
  end

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