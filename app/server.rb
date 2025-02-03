# frozen_string_literal: true

require 'socket'

server = TCPServer.new('localhost', 4221)

HTTP_RESPONSE_PATTERN = "HTTP/1.1 %s\r\n%s\r\n%s"
HTTP_RESPONSE_CODE = {
  200 => '200 OK',
  404 => '404 Not Found'
}.freeze

def respond_to_client(client, status, headers, body)
  client.puts format(HTTP_RESPONSE_PATTERN, HTTP_RESPONSE_CODE[status], headers, body)
end

loop do
  client = server.accept
  request = client.gets.chomp
  _, path = request.split

  if path == '/'
    respond_to_client client, 200, '', ''
  else
    respond_to_client client, 404, '', ''
  end

  client.close
end
