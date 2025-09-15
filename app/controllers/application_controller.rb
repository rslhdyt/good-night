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

  rescue_from Unauthorized do
    render json: { error: "unauthorized" }, status: :unauthorized
  end
end
