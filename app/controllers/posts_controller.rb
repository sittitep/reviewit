class PostsController < ApplicationController
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

  private

  def post_params
    params.fetch(:post, {}).permit(:title, :url)
  end
end
