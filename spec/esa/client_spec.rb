require "spec_helper"

RSpec.describe Esa::Client do
  let(:access_token) { nil }
  let(:api_endpoint) { nil }
  let(:current_team) { nil }
  let(:default_headers) { {} }
  let(:options) do
    {
      access_token: access_token,
      api_endpoint: api_endpoint,
      current_team: current_team,
      default_headers: default_headers
    }
  end
  subject(:client) { described_class.new(**options) }

  describe "#current_team!" do
    context 'team not specified' do
      it 'raise error' do
        expect do
          client.current_team!
        end.to raise_error Esa::TeamNotSpecifiedError
      end
    end

    context 'team specified' do
      let(:current_team) { '<team>' }
      it 'return current_team' do
        expect(client.current_team).to eq current_team
      end
    end
  end

  %i(get post put patch delete).each do |method|
    describe "#send_#{method}" do
      let(:path)    { '<path>' }
      let(:params)  { '<params>' }
      let(:headers) { '<headers>' }
      it "call send_request with method, path, params and headers" do
        expect(client).to receive(:send_request).with(method, path, params, headers)
        client.__send__("send_#{method}", path, params, headers)
      end
    end
  end

  describe 'default_headers' do
    before do
      stub_request(:any, 'https://api.esa.io/v1/teams')
        .to_return do |request|
          {
            body: request.body,
            headers: request.headers
          }
        end
    end

    context 'no default_headers option' do
      it 'request with basic headers' do
        response = client.teams
        expect(response.headers).to eq(
          'Accept' => 'application/json',
          'User-Agent' => "Esa Ruby Gem #{Esa::VERSION}",
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'
        )
      end

      it 'request with basic headers and additional headers ' do
        response = client.teams(nil, { 'X-Foo' => 'bar' })
        expect(response.headers).to eq(
          'Accept' => 'application/json',
          'User-Agent' => "Esa Ruby Gem #{Esa::VERSION}",
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'X-Foo' => 'bar'
        )
      end
    end

    context 'with default_headers option' do
      let(:default_headers) { { 'X-Default-Foo' => 'Bar' } }

      it 'request with basic headers and default_headers' do
        response = client.teams
        expect(response.headers).to eq(
          'Accept' => 'application/json',
          'User-Agent' => "Esa Ruby Gem #{Esa::VERSION}",
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'X-Default-Foo' => 'Bar'
        )
      end

      it 'request with basic headers and additional headers ' do
        response = client.teams(nil, { 'X-Foo' => 'baz', 'X-Default-Foo' => 'qux' })
        expect(response.headers).to eq(
          'Accept' => 'application/json',
          'User-Agent' => "Esa Ruby Gem #{Esa::VERSION}",
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'X-Default-Foo' => 'qux',
          'X-Foo' => 'baz'
        )
      end
    end
  end
end
