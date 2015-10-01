require 'esa/errors'
require 'esa/api_methods'
require "esa/response"

module Esa
  class Client
    include ApiMethods

    def initialize(access_token: nil, api_endpoint: nil, current_team: nil)
      @access_token = access_token
      @api_endpoint = api_endpoint
      @current_team = current_team
    end
    attr_accessor :current_team

    def current_team!
      raise TeamNotSpecifiedError, "current_team is not specified" unless @current_team
      current_team
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

    def send_request(method, path, params = nil, headers = nil)
      Esa::Response.new(esa_connection.send(method, path, params, headers))
    end

    def send_s3_request(method, path, params = nil, headers = nil)
      Esa::Response.new(s3_connection.send(method, path, params, headers))
    end

    def send_simple_request(method, path, params = nil, headers = nil)
      Esa::Response.new(simple_connection.send(method, path, params, headers))
    end

    def esa_connection
      @esa_connection ||= Faraday.new(faraday_options) do |c|
        c.request :json
        c.response :json
        c.adapter Faraday.default_adapter
      end
    end

    def s3_connection
      @s3_connection ||= Faraday.new do |c|
        c.request :multipart
        c.request :url_encoded
        c.response :xml
        c.adapter Faraday.default_adapter
      end
    end

    def simple_connection
      @simple_connection ||= Faraday.new do |c|
        c.adapter Faraday.default_adapter
      end
    end

    private

    def faraday_options
      {
        url:     faraday_url,
        headers: faraday_headers
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
