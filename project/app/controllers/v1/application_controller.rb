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

  def current_user
    @current_user ||= JSON[cookies['user']]
  end

  def set_headers
    headers['Access-Control-Allow-Origin']      = 'http://professorfinanceiro.herokuapp.com'
    headers['Access-Control-Allow-Methods']     = 'GET, POST, OPTIONS, PUT, PATCH, DELETE'
    headers['Access-Control-Allow-Headers']     = 'X-Requested-With,content-type'
    headers['Access-Control-Allow-Credentials'] = 'true'
  end

  def default_format_json
    request.format = "json"
  end
end
