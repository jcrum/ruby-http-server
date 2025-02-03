# frozen_string_literal: true

require 'net/http'
require 'spec_helper'

RSpec.describe 'HTTP Server' do
  let(:url) { URI(server_url) }

  it 'responds with a message' do
    response = Net::HTTP.get_response(url)
    expect(response.code).to eq('200')
    expect(response.body).to eq('')
  end
end
