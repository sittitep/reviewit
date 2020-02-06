class User < ApplicationRecord
  has_many :posts
  has_many :votes
  has_many :comments
  has_many :moderators

  def name
    super.presence || "anonymous"
  end

  def profile_url
    super.presence || "/"
  end
end
