class WelcomeController < ApplicationController
  def index
    @posts = Post.order("vote_count DESC").includes(:user).page(params[:page])
  end
end
