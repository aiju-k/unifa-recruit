require "net/http"
require "uri"

class HttpRequestBase
  def initialize
  end

  def post_request(url, params, headers = nil)
    uri = URI.parse(url)

    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = params.to_json

    if headers
      request.initialize_http_header(headers)
    end

    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end

    response
  end
end
