class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_one :branch, through: :post

  has_many :votes, dependent: :destroy, as: :originator

  after_create do
    contributor = Contributor.find_or_initialize_by(user_id: self.user_id, branch_id: self.branch.id)
    contributor.points += 1
    contributor.save!
  end

  after_commit do
    self.post.comment_count = Comment.where(post_id: self.post.id).count
    self.post.save
  end
end
