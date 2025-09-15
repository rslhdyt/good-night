module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError do |e|
      # add logger here

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
end
