class ApplicationController < ActionController::API
  include Pundit

  rescue_from Mongoid::Errors::DocumentNotFound, with: :render_404
  rescue_from Pundit::NotAuthorizedError, with: :render_403
  rescue_from ActionController::ParameterMissing, with: :render_400

  def render_400
    render json: {}, status: 400
  end

  def render_403
    render json: {}, status: 403
  end

  def render_404
    render json: {}, status: 404
  end

  def current_user
    nil
  end
end
