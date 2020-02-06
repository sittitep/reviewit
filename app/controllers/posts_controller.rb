class PostsController < ApplicationController
  before_action :authenticate_user, except: [:show, :index]
  before_action :set_post, only: [:show, :destroy, :resolve, :close]
  before_action :set_branch_path, only: [:index, :show]
  before_action :set_post_path, only: [:show]

  def index
    @posts = @branch.posts.open.includes(:user).page(params[:page])
    # @contributors = User.joins(:posts, :comments).group("users.id").select("users.*, count(posts.id) + count(comments.id) AS count").order("count DESC").limit(3)
  end

  def new
    @post = Post.new
  end

  def show
    @comments = @post.comments.order("created_at ASC")
    @moderator = User.first
    @contributors = User.joins(:posts, :comments).group("users.id").select("users.*, count(posts.id) + count(comments.id) AS count").order("count DESC").limit(3)
  end

  def create
    post = current_user.posts.create!(post_params)

    flash[:notice] = {success: "You have created the post!"}

    redirect_to slug_post_path(branch: post.branch.slug, id: post.id, slug: post.slug)
  end

  def destroy
    @post.touch(:deleted_at)
    
    flash[:notice] = {success: "You have removed the post!"}

    redirect_back(fallback_location: root_path)
  end

  def resolve
    @post.touch(:resolved_at)
    @post.touch(:closed_at)

    flash[:notice] = {success: "You have resolved the post!"}

    redirect_back(fallback_location: root_path)
  end

  def close
    @post.touch(:closed_at)
    
    flash[:notice] = {success: "You have closed the post!"}

    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.fetch(:post, {}).permit(:title, :url, :branch_id)
  end

  def scope
    @current_scope = params[:scope]&.to_sym || :open
  end  

  def set_post
    @post ||= Post.find(params[:id])
  end

  def set_branch_path
    add_breadcrumb(@branch.display_name, branch_path(branch: @branch.slug))
  end

  def set_post_path
    add_breadcrumb(@post.title, slug_post_path(branch: 'master', id: params[:id], slug: params[:slug]))
  end
end
