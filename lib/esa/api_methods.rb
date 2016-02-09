module Esa
  module ApiMethods
    HTTP_REGEX = %r{^https?://}

    def teams(params = nil, headers = nil)
      send_get("/v1/teams", params, headers)
    end

    def team(team_name, params = nil, headers = nil)
      send_get("/v1/teams/#{team_name}", params, headers)
    end

    def stats(params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/stats", params, headers)
    end

    def members(params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/members", params, headers)
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

    def create_sharing(post_number, params = nil, headers = nil)
      send_post("/v1/teams/#{current_team!}/posts/#{post_number}/sharing", params, headers)
    end

    def delete_sharing(post_number, params = nil, headers = nil)
      send_delete("/v1/teams/#{current_team!}/posts/#{post_number}/sharing", params, headers)
    end

    class PathStringIO < StringIO
      attr_accessor :path

      def initialize(*args)
        super(*args[1..-1])
        @path = args[0]
      end
    end

    # beta
    def upload_attachment(path_or_file_or_url, params = {}, headers = nil)
      file = file_from(path_or_file_or_url)
      setup_params_for_upload(params, file)

      response = send_post("/v1/teams/#{current_team!}/attachments/policies", params, headers)
      return response unless response.status == 200

      attachment = response.body['attachment']
      form_data  = response.body['form'].merge(file: Faraday::UploadIO.new(file, params[:type]))

      s3_response = send_s3_request(:post, attachment['endpoint'], form_data)
      return s3_response unless s3_response.status == 204

      response.body.delete('form')
      response
    end

    private

    def wrap(params, envelope)
      return params if params.nil?
      return params unless params.is_a?(Hash)
      return params if params.has_key?(envelope.to_sym) || params.has_key?(envelope.to_s)
      { envelope => params }
    end

    def content_type_from_file(file)
      require 'mime/types'
      if mime_type = MIME::Types.type_for(file.path).first
        mime_type.content_type
      end
    rescue LoadError
      msg = 'Please pass content_type or install mime-types gem to guess content type from file'
      raise MissingContentTypeErrork, msg
    end

    def file_from(path_or_file_or_url)
      path_or_file_or_url, cookie = *path_or_file_or_url if path_or_file_or_url.is_a?(Array)

      if path_or_file_or_url.respond_to?(:read)
        path_or_file_or_url
      elsif path_or_file_or_url.is_a?(String) && HTTP_REGEX.match(path_or_file_or_url)
        remote_url = path_or_file_or_url
        headers = {}
        headers[:Cookie] = cookie if cookie
        response = send_simple_request(:get, remote_url, nil, headers)
        raise RemoteURLNotAvailableError, "#{remote_url} is not available." unless response.status == 200
        PathStringIO.new(File.basename(remote_url), response.body)
      else
        path = path_or_file_or_url
        File.new(path, "r+b")
      end
    end

    def setup_params_for_upload(params, file)
      params[:type] = params.delete(:content_type) || content_type_from_file(file)
      params[:size] = file.size
      params[:name] = File.basename(file.path)
    end
  end
end
