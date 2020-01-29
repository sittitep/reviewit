class PostsController < ApplicationController
  before_action :authenticate_user

  def new
    @post = Post.new
  end

  def create
    current_user.posts.create(post_params)

    redirect_to root_path
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    
    redirect_to root_path
  end

  def up
    vote = Vote.find_or_initialize_by(post_id: params[:id], user_id: current_user.id)
    vote.value = 1
    vote.save

    redirect_back(fallback_location: root_path)
  end

  def down
    vote = Vote.find_or_initialize_by(post_id: params[:id], user_id: current_user.id)
    vote.value = -1
    vote.save

    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.fetch(:post, {}).permit(:title, :url)
  end
end
