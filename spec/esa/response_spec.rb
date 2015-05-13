require 'spec_helper'

RSpec.describe Esa::Response do
  let(:response_status) { 401 }
  let(:response_body) { '{"error":"unauthorized", "message":"Unauthorized"}' }
  let(:response_headers) do
    {
      'server' => 'Cowboy',
      'content-type' => 'application/json; charset=utf-8',
    }
  end
  let(:connection) do
    Faraday.new do |c|
      c.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/test') { [response_status, response_headers, response_body] }
      end
    end
  end
  let(:response) { described_class.new(connection.get('/test')) }

  describe '#body' do
    subject { response.body }
    it { is_expected.to eq response_body }
  end

  describe '#headers' do
    subject { response.headers }
    let(:expectation) do
      {
        'Server' => 'Cowboy',
        'Content-Type' => 'application/json; charset=utf-8',
      }
    end

    it { is_expected.to eq expectation }
  end

  describe '#status' do
    subject { response.status }
    it { is_expected.to eq response_status }
  end
end
