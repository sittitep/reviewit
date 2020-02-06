class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :set_branch

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
    redirect_to Github.authentication_url unless current_user
  end

  alias set_current_user current_user

  def set_branch
    @branch ||= Branch.find_by!(slug: params[:branch]) if params[:branch]
  end
end
