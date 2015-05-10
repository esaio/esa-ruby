require 'esa/api_methods'
require "esa/response"
require 'esa/errors'

module Esa
  class Client
    include ApiMethods

    def initialize(access_token: nil, api_endpoint: nil, current_team: nil)
      @access_token = access_token
      @api_endpoint = api_endpoint
      @current_team = current_team
    end
    attr_writer :current_team

    def current_team
      raise TeamNotSpecifiedError, "current_team is not specified" unless @current_team
      @current_team
    end

    def send_get(path, params = nil, headers = nil)
      send_request(:get, path, params, headers)
    end

    def send_post(path, params = nil, headers = nil)
      send_request(:post, path, params, headers)
    end

    def send_put(path, params = nil, headers = nil)
      send_request(:put, path, params, headers)
    end

    def send_patch(path, params = nil, headers = nil)
      send_request(:patch, path, params, headers)
    end

    def send_delete(path, params = nil, headers = nil)
      send_request(:delete, path, params, headers)
    end

    def send_request(method, path, params, headers)
      Esa::Response.new(connection.send(method, path, params, headers))
    end

    def connection
      @connection ||= Faraday.new(faraday_options) do |c|
        c.request  :json
        c.response :json
        c.adapter  Faraday.default_adapter
      end
    end

    private

    def faraday_options
      {
        url:     faraday_url,
        headers: faraday_headers,
        # ssl:     { verify: !!faraday_url.match(/^https:\/\//) },
      }
    end

    def default_headers
      {
        'Accept'       => 'application/json',
        'User-Agent'   => "Esa Ruby Gem #{Esa::VERSION}",
      }
    end

    def faraday_headers
      return default_headers unless access_token
      default_headers.merge(Authorization: "Bearer #{access_token}")
    end

    def access_token
      @access_token || ENV['ESA_ACCESS_TOKEN']
    end

    def faraday_url
      @api_endpoint || ENV["ESA_API_ENDPOINT"] || "https://api.esa.io"
    end
  end
end
