class WelcomeController < ApplicationController
  def index
    @posts = Post.order("vote_count DESC").includes(:user).all
  end
end
