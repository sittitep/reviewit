class Vote < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_create :set_post_vote_count
  after_update :set_post_vote_count

  private 

  def set_post_vote_count
    self.post.vote_count = self.post.votes.sum(:value)
    self.post.save
  end
end
