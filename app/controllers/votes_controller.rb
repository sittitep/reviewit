class VotesController < ApplicationController
  before_action :authenticate_user

  def create
    originator = params[:originator_type].constantize.find(params[:originator_id])
    vote = originator.votes.find_or_initialize_by(user_id: current_user.id)
    vote.value = 1
    vote.save!

    flash[:notice] = {success: "You have voted up the post!"}

    redirect_back(fallback_location: root_path)    
  end

  def destroy
    originator = params[:originator_type].constantize.find(params[:originator_id])
    vote = originator.votes.find_or_initialize_by(user_id: current_user.id)    
    vote.value = -1
    vote.save

    flash[:notice] = {warning: "You have voted down the post!"}

    redirect_back(fallback_location: root_path) 
  end
end
