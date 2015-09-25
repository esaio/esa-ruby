module Esa
  module ApiMethods
    def teams(params = nil, headers = nil)
      send_get("/v1/teams", params, headers)
    end

    def team(team_name, params = nil, headers = nil)
      send_get("/v1/teams/#{team_name}", params, headers)
    end

    def stats(team_name, params = nil, headers = nil)
      send_get("/v1/teams/#{team_name}/stats", params, headers)
    end

    def posts(params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/posts", params, headers)
    end

    def post(post_number, params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/posts/#{post_number}", params, headers)
    end

    def create_post(params = nil, headers = nil)
      send_post("/v1/teams/#{current_team!}/posts", wrap(params, :post), headers)
    end

    def update_post(post_number, params = nil, headers = nil)
      send_patch("/v1/teams/#{current_team!}/posts/#{post_number}", wrap(params, :post), headers)
    end

    def delete_post(post_number, params = nil, headers = nil)
      send_delete("/v1/teams/#{current_team!}/posts/#{post_number}", params, headers)
    end

    def comments(post_number,  params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/posts/#{post_number}/comments", params, headers)
    end

    def comment(comment_id, params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/comments/#{comment_id}", params, headers)
    end

    def create_comment(post_number, params = nil, headers = nil)
      send_post("/v1/teams/#{current_team!}/posts/#{post_number}/comments", wrap(params, :comment), headers)
    end

    def update_comment(comment_id, params = nil, headers = nil)
      send_patch("/v1/teams/#{current_team!}/comments/#{comment_id}", wrap(params, :comment), headers)
    end

    def delete_comment(comment_id, params = nil, headers = nil)
      send_delete("/v1/teams/#{current_team!}/comments/#{comment_id}", params, headers)
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
