module Esa
  class Response
    def initialize(faraday_response)
      @raw_body    = faraday_response.body
      @raw_headers = faraday_response.headers
      @raw_status  = faraday_response.status
    end

    def body
      @raw_body
    end

    def headers
      @headers ||= @raw_headers.headers.inject({}) do |result, (key, value)|
        result.merge(key.split("-").map(&:capitalize).join("-") => value)
      end
    end

    def status
      @raw_status
    end
  end
end
