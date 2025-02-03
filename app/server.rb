# frozen_string_literal: true

require 'socket'

server = TCPServer.new('localhost', 4221)

loop do
  client = server.accept
  request = client.gets.chomp
  _, path = request.split

  if path == '/'
    client.puts format("HTTP/1.1 %s\r\n%s\r\n%s", 200, '', '')
  else
    # do somethign here soon
  end

  client.close
end
