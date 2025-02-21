require "net/http"
require "uri"

class OauthController < ApplicationController
  def new
    base_url = ENV["OAUTH_BASE_URL"] + "authorize?"
    query_params = {
      client_id: ENV["CLIENT_ID"],
      response_type: "code",
      redirect_uri: "http://localhost:3000/oauth/callback",
      scope: "write_tweet"
    }
    query_string = query_params.map do |key, value|
      "#{key}=#{value}"
    end.join("&")

    redirect_to base_url + query_string, allow_other_host: true
  end

  def callback
    code = params["code"]

    if code
      url = ENV["OAUTH_BASE_URL"] + "token"

      params = {
        code:,
        client_id: ENV["CLIENT_ID"],
        client_secret: ENV["CLIENT_SECRET"],
        redirect_uri: "http://localhost:3000/oauth/callback",
        grant_type: "authorization_code"
      }

      response = HttpRequestBase.new().post_request(url, params)
      body = JSON.parse(response.body)

      if body["access_token"]
        session[:access_token] = body["access_token"]
        redirect_to pictures_path
      end
    else
      head :no_content
    end
  end

  private

  def generate_query_string(query_params)
    query_params.map do |key, value|
      "#{key}=#{value}"
    end.join("&")
  end
end
