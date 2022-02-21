require 'base64'
require 'mime/types'

module Esa
  module ApiMethods
    HTTP_REGEX = %r{^https?://}

    def user(params = nil, headers = nil)
      send_get("/v1/user", params, headers)
    end

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

    def delete_member(screen_name, params = nil, headers = nil)
      send_delete("/v1/teams/#{current_team!}/members/#{screen_name}", params, headers)
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

    def append_post(post_number, params = nil, headers = nil)
      send_post("/v1/teams/#{current_team!}/posts/#{post_number}/append", wrap(params, :post), headers)
    end

    def delete_post(post_number, params = nil, headers = nil)
      send_delete("/v1/teams/#{current_team!}/posts/#{post_number}", params, headers)
    end

    def comments(post_number = nil, params = nil, headers = nil)
      if post_number.nil?
        send_get("/v1/teams/#{current_team!}/comments", params, headers)
      else
        send_get("/v1/teams/#{current_team!}/posts/#{post_number}/comments", params, headers)
      end
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

    def post_stargazers(post_number, params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/posts/#{post_number}/stargazers", params, headers)
    end

    def add_post_star(post_number, params = nil, headers = nil)
      send_post("/v1/teams/#{current_team!}/posts/#{post_number}/star", params, headers)
    end

    def delete_post_star(post_number, params = nil, headers = nil)
      send_delete("/v1/teams/#{current_team!}/posts/#{post_number}/star", params, headers)
    end

    def comment_stargazers(comment_id, params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/comments/#{comment_id}/stargazers", params, headers)
    end

    def add_comment_star(comment_id, params = nil, headers = nil)
      send_post("/v1/teams/#{current_team!}/comments/#{comment_id}/star", params, headers)
    end

    def delete_comment_star(comment_id, params = nil, headers = nil)
      send_delete("/v1/teams/#{current_team!}/comments/#{comment_id}/star", params, headers)
    end

    def watchers(post_number, params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/posts/#{post_number}/watchers", params, headers)
    end

    def add_watch(post_number, params = nil, headers = nil)
      send_post("/v1/teams/#{current_team!}/posts/#{post_number}/watch", params, headers)
    end

    def delete_watch(post_number, params = nil, headers = nil)
      send_delete("/v1/teams/#{current_team!}/posts/#{post_number}/watch", params, headers)
    end

    def categories(params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/categories", params, headers)
    end

    def batch_move_category(params = nil, headers = nil)
      send_post("/v1/teams/#{current_team!}/categories/batch_move", params, headers)
    end

    def tags(params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/tags", params, headers)
    end

    def invitation(params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/invitation", params, headers)
    end

    def regenerate_invitation(params = nil, headers = nil)
      send_post("/v1/teams/#{current_team!}/invitation_regenerator", params, headers)
    end

    def pending_invitations(params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/invitations", params, headers)
    end

    def send_invitation(emails, params = {}, headers = nil)
      params = params.merge(member: { emails: emails } )
      send_post("/v1/teams/#{current_team!}/invitations", params, headers)
    end

    def cancel_invitation(code, params = nil, headers = nil)
      send_delete("/v1/teams/#{current_team!}/invitations/#{code}", params, headers)
    end

    def emojis(params = nil, headers = nil)
      send_get("/v1/teams/#{current_team}/emojis", params, headers)
    end

    def create_emoji(params = nil, headers = nil)
      params[:image] = Base64.strict_encode64(File.read(params[:image])) if params[:image]
      send_post("/v1/teams/#{current_team!}/emojis", wrap(params, :emoji), headers)
    end

    def delete_emoji(emoji_code, params = nil, headers = nil)
      send_delete("/v1/teams/#{current_team!}/emojis/#{emoji_code}", params, headers)
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

    def signed_url(file_path, params = nil, headers = nil)
      send_get("/v1/teams/#{current_team!}/signed_url/#{file_path}", params, headers)
    end

    private

    def wrap(params, envelope)
      return params if params.nil?
      return params unless params.is_a?(Hash)
      return params if params.has_key?(envelope.to_sym) || params.has_key?(envelope.to_s)
      { envelope => params }
    end

    def content_type_from_file(file)
      if mime_type = MIME::Types.type_for(file.path).first
        mime_type.content_type
      end
    rescue LoadError
      msg = 'Please pass content_type or install mime-types gem to guess content type from file'
      raise MissingContentTypeError, msg
    end

    def file_from(path_or_file_or_url)
      path_or_file_or_url, headers_or_cookie = *path_or_file_or_url if path_or_file_or_url.is_a?(Array)

      if path_or_file_or_url.respond_to?(:read)
        path_or_file_or_url
      elsif path_or_file_or_url.is_a?(String) && HTTP_REGEX.match(path_or_file_or_url)
        remote_url = path_or_file_or_url
        headers =
          if headers_or_cookie
            headers_or_cookie.is_a?(Hash) ? headers_or_cookie : { Cookie: headers_or_cookie }
          else
            {}
          end
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
