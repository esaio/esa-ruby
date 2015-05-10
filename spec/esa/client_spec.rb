require "spec_helper"

RSpec.describe Esa::Client do
  let(:access_token) { nil }
  let(:api_endpoint) { nil }
  let(:current_team) { nil }
  let(:options) do
    {
      access_token: access_token,
      api_endpoint: api_endpoint,
      current_team: current_team,
    }
  end
  subject(:client) { described_class.new(options) }

  describe "#current_team" do
    context 'team not specified' do
      it 'raise error' do
        expect do
          client.current_team
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

  # describe "#send_request", :vcr do
  #   it 'returns Esa::Response' do
  #     expect(client.teams).to be_a Esa::Response
  #   end
  # end
end
