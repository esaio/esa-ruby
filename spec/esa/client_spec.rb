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

  describe '#upload_attachment' do
    let(:current_team) { 'test-team' }
    let(:file) { File.open('spec/fixtures/files/egg.png') }

    before do
      stub_request(:post, "https://api.esa.io/v1/teams/test-team/attachments/policies")
        .with(
          body: "{\"type\":\"image/png\",\"size\":49816,\"name\":\"egg.png\"}",
          headers: {
            'Accept'=>'application/json',
          }
        )
        .to_return(
          status: 200,
          body: {
            attachment: {
              endpoint: 'https://test.s3-ap-northeast-1.amazonaws.com',
              url: 'https://example.com/test.png'
            },
            form: {
              foo: 'bar'
            }
          }.to_json,
          headers: {}
        )

        stub_request(:post, "https://test.s3-ap-northeast-1.amazonaws.com/")
          .to_return(status: 204, body: "", headers: {
            'Content-Type' => 'application/xml'
          })
    end

    it 'return URL for uploaded attachment'do
      response = client.upload_attachment(file)
      expect(response.body['attachment']['url']).to eq('https://example.com/test.png')
    end
  end
end
