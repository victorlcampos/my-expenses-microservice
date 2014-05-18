require 'json'
class V1::ApplicationController < ActionController::Base
  respond_to :json

  skip_before_filter :verify_authenticity_token
  before_filter :default_format_json
  before_filter :set_headers

  def handle_options_request
    head(:ok) if request.request_method == "OPTIONS"
  end

  private

  def user_id
    @user_id ||= JWT.decode(params[:token], ENV["SECRET_TOKEN"] || "MEAN")[0]["id"]
  end

  def set_headers
      headers['Access-Control-Allow-Origin']      = request.headers["HTTP_ORIGIN"]
      headers['Access-Control-Expose-Headers']    = 'ETag'
      headers['Access-Control-Allow-Methods']     = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
      headers['Access-Control-Allow-Headers']     = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
      headers['Access-Control-Max-Age']           = '86400'
      headers['Access-Control-Allow-Credentials'] = 'true'
  end

  def default_format_json
    request.format = "json"
  end
end
