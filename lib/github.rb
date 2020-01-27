require 'oauth2'

class Github
  class << self 
    def get_access_token(code)
      uri = URI('https://github.com/login/oauth/access_token')
      res = Net::HTTP.post_form(uri, client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"], code: code)

      Rack::Utils.parse_nested_query(res.body)
    end

    def authentication_url 
      client.auth_code.authorize_url(:redirect_uri => ENV["APP_HOST"] + "/auth/github/callback", scope: "read:user")
    end

    def client
      @client ||= OAuth2::Client.new(ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_CLIENT_SECRET"], :site => 'https://github.com', authorize_url: 'login/oauth/authorize')
    end
  end
end
