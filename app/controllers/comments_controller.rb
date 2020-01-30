class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    comment = Comment.new(user_id: current_user.id, post_id: params[:post_id], text: comment_params[:text])
    comment.save

    flash[:notice] = {success: "You have commented!"}

    redirect_back(fallback_location: root_path)
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.user == current_user
      comment.destroy
      flash[:notice] = {warning: "You have removed a comment!"}
    end

    redirect_back(fallback_location: root_path)    
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
