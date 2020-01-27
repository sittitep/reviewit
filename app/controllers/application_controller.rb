class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  def current_user
    return unless cookies[:current_user_id]

    begin
      @current_user ||= User.find(cookies[:current_user_id])
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  def authenticate_user
    raise "Unauthorized" unless current_user
  end

  alias set_current_user current_user
end
