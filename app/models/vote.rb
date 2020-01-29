class Vote < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_commit do
    self.post.vote_count = self.post.votes.sum(:value)
    self.post.save
  end
end
