class Post < ApplicationRecord
  QUERY_SCOPES = [:all, :open, :closed]

  belongs_to :user
  has_many :votes, dependent: :destroy, as: :originator
  has_many :comments, dependent: :destroy

  scope :open, -> { where(resolved_at: nil, closed_at: nil, deleted_at: nil) }
  scope :closed, -> { where.not(closed_at: nil) }

  def open?
    resolved_at.blank? && closed_at.blank? && deleted_at.blank?
  end

  def slug
    self.title.downcase.gsub(" ","-")    
  end
end
