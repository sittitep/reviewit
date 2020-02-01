class PostsController < ApplicationController
  before_action :authenticate_user, except: [:show]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    post = current_user.posts.create(post_params)

    flash[:notice] = {success: "You have created the post!"}

    redirect_to slug_post_path(id: post.id, slug: post.slug)
  end

  def destroy
    post = Post.find(params[:id])
    post.touch(:deleted_at)
    
    flash[:notice] = {success: "You have removed the post!"}

    redirect_back(fallback_location: root_path)
  end

  def resolve
    post = Post.find(params[:id])
    post.touch(:resolved_at)
    
    flash[:notice] = {success: "You have resolved the post!"}

    redirect_back(fallback_location: root_path)
  end

  def close
    post = Post.find(params[:id])
    post.touch(:closed_at)
    
    flash[:notice] = {success: "You have closed the post!"}

    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.fetch(:post, {}).permit(:title, :url)
  end
end
