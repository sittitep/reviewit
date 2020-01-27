class SessionsController < ApplicationController
  def destroy
    cookies.delete(:current_user_id)

    redirect_to root_path
  end
end
