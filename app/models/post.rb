class Post < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy, as: :originator
  has_many :comments, dependent: :destroy

  scope :active, -> { where(resolved_at: nil, closed_at: nil, deleted_at: nil) }

  def active?
    resolved_at.blank? && closed_at.blank? && deleted_at.blank?
  end

  def slug
    self.title.downcase.gsub(" ","-")    
  end
end
