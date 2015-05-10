module Esa
  module ApiMethods
    def teams(params = nil, headers = nil)
      send_get("/v1/teams", params, headers)
    end

    def team(name, params = nil, headers = nil)
      send_get("/v1/teams/#{name}", params, headers)
    end

    def posts(params = nil, headers = nil)
      send_get("/v1/teams/#{current_team}/posts", params, headers)
    end

    def post(number, params = nil, headers = nil)
      send_get("/v1/teams/#{current_team}/posts/#{number}", params, headers)
    end

    def create_post(params = nil, headers = nil)
      send_post("/v1/teams/#{current_team}/posts", wrap(params, :post), headers)
    end

    def update_post(number, params = nil, headers = nil)
      send_patch("/v1/teams/#{current_team}/posts/#{number}", wrap(params, :post), headers)
    end

    def delete_post(number, params = nil, headers = nil)
      send_delete("/v1/teams/#{current_team}/posts/#{number}", params, headers)
    end

    private

    def wrap(params, envelope)
      return params if params.nil?
      return params unless params.is_a?(Hash)
      return params if params.has_key?(envelope.to_sym) || params.has_key?(envelope.to_s)
      { envelope => params }
    end
  end
end
