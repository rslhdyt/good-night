class ApplicationController < ActionController::API
  before_action :authenticate_user!

  class Unauthorized < StandardError; end

  def current_user
    @current_user ||= User.find_by(id: header_user_id)
  end

  private

  def authenticate_user!
    raise Unauthorized if header_user_id.blank?
    raise Unauthorized if current_user.blank?
  end

  def header_user_id
    request.headers["X-User-Id"]
  end

  rescue_from StandardError do |e|
    render json: { 
      error: e.message, 
      backtrace: e.backtrace.first(10) 
    }, status: :internal_server_error
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: e.message }, status: :not_found
  end

  rescue_from Unauthorized do
    render json: { error: "unauthorized" }, status: :unauthorized
  end
end
