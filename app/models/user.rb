class User < ApplicationRecord
  has_many :posts
  has_many :votes
  has_many :comments

  def name
    super.presence || "anonymous"
  end

  def profile_url
    super.presence || "/"
  end
end
