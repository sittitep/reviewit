class WelcomeController < ApplicationController
  def index
    @posts = Post.order("created_at DESC").includes(:user).all
  end
end
