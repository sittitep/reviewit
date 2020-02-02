class WelcomeController < ApplicationController
  def index
    @posts = Post.send(scope).includes(:user).page(params[:page])
  end

  private

  def scope
    @current_scope = params[:scope]&.to_sym || :open
  end
end
