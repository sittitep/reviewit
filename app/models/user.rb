class User < ApplicationRecord
  has_many :posts
  has_many :voutes

  def name
    super.presence || "anonymous"
  end

  def profile_url
    super.presence || "/"
  end
end
