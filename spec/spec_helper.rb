# frozen_string_literal: true

require 'rspec'
require 'net/http'

module RSpecMixin
  def server_url
    'http://localhost:4221'
  end

  def get_response(path: '/', url: server_url)
    Net::HTTP.get_response(URI.join(url, path))
  end
end

RSpec.configure do |config|
  config.include RSpecMixin

  pid = nil
  server_file = File.expand_path('../app/server.rb', __dir__)

  config.before(:suite) do
    pid = Process.spawn("bundle exec ruby #{server_file}", out: 'logs/test_server.out.log',
                                                           err: 'logs/test_server.out.log')
    Process.detach(pid)
    sleep 1
  end

  config.after(:suite) do
    if pid
      begin
        Process.kill('INT', pid)
        sleep 1
        Process.wait(pid)
      rescue Errno::ESRCH, Errno::ECHILD
        # Errno::ESRCH - PID can't be found
        # Errno::ECHILD - no child processes
        # don't know what I am going to do here but
        # will figure it out at some point
      end
    end
  end
end
