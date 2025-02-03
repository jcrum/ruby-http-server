# frozen_string_literal: true

require 'net/http'
require 'spec_helper'

RSpec.describe 'HTTP Server: 2##' do
  let(:url) { URI(server_url) }

  it 'responds with a message' do
    response = get_response
    expect(response.code).to eq('200')
    expect(response.body).to eq('')
  end
end

RSpec.describe 'HTTP Server: 4##' do
  let(:url) { URI(server_url) }

  it 'responds with 404 when a path can not be found' do
    response = get_response(path: 'i-dont-exist')
    expect(response.code).to eq('404')
    expect(response.body).to eq('')
  end
end
