class Branch < ApplicationRecord
  validates :name, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  before_save :set_slug

  has_many :posts
  has_many :moderators
  has_many :contributors, -> { order("points DESC") }

  def set_slug
    self.slug = self.name.downcase
  end

  def display_name
    "b/#{self.name}"
  end
end
