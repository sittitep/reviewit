class PostsController < ApplicationController
  before_action :authenticate_user, except: [:show]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    current_user.posts.create(post_params)

    flash[:notice] = {success: "You have created the post!"}

    redirect_to root_path
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    
    flash[:notice] = {success: "You have removed the post!"}

    redirect_to root_path
  end

  def up
    vote = Vote.find_or_initialize_by(post_id: params[:id], user_id: current_user.id)
    vote.value = 1
    vote.save

    flash[:notice] = {success: "You have voted up the post!"}

    redirect_back(fallback_location: root_path)
  end

  def down
    vote = Vote.find_or_initialize_by(post_id: params[:id], user_id: current_user.id)
    vote.value = -1
    vote.save

    flash[:notice] = {warning: "You have voted down the post!"}

    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.fetch(:post, {}).permit(:title, :url)
  end
end
