class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :votes, dependent: :destroy, as: :originator

  after_commit do
    self.post.comment_count = Comment.where(post_id: self.post.id).count
    self.post.save
  end
end
