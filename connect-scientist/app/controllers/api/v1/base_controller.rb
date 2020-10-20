class Api::V1::BaseController < ActionController::API
  def respond_404_with_error_message(message)
    render json: { error: { message: message } }, status: 404
  end
end
