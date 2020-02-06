class PostsController < ApplicationController
  before_action :authenticate_user, except: [:show, :index]
  before_action :set_post, only: [:show, :destroy, :resolve, :close, :edit]
  before_action :set_branch_path, only: [:index, :show, :new, :edit]
  before_action :set_post_path, only: [:show, :edit]
  before_action :set_action_post_path, only: [:new, :edit]

  def index
    model = @branch.slug == "master" ? Post : @branch.posts

    @posts = model.open.includes(:user).page(params[:page])
  end

  def new
    @post = Post.new(branch_id: @branch.id)
  end

  def edit
  end

  def show
    @comments = @post.comments.order("created_at ASC")
  end

  def create
    post = current_user.posts.create!(post_params)

    flash[:notice] = {success: "You have created the post!"}

    redirect_to slug_branch_post_path(branch: post.branch.slug, id: post.id, slug: post.slug)
  end

  def update
    post = current_user.posts.find(params[:id])
    post.assign_attributes(post_params)
    post.save!

    flash[:notice] = {success: "You have updated the post!"}

    redirect_to slug_branch_post_path(branch: post.branch.slug, id: post.id, slug: post.slug)    
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
    add_breadcrumb(@post.title, slug_branch_post_path(branch: @branch.slug, id: @post.id, slug: @post.slug))
  end

  def set_action_post_path
    if @post&.persisted?
      add_breadcrumb("Edit Post", edit_branch_post_path(branch: @branch.slug, id: @post.id))
    else
      add_breadcrumb("New Post", new_branch_post_path(branch: @branch.slug))
    end
  end
end
