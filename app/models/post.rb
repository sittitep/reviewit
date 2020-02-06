class Post < ApplicationRecord
  belongs_to :user
  belongs_to :branch
  
  has_many :votes, dependent: :destroy, as: :originator
  has_many :comments, dependent: :destroy

  scope :open, -> { where(resolved_at: nil, closed_at: nil, deleted_at: nil).reorder("vote_count DESC") }
  scope :closed, -> { where.not(closed_at: nil).reorder("closed_at DESC") }

  after_create do
    contributor = Contributor.find_or_initialize_by(user_id: self.user_id, branch_id: self.branch_id)
    contributor.points += 1
    contributor.save!
  end  

  def open?
    resolved_at.blank? && closed_at.blank? && deleted_at.blank?
  end

  def self.all
    super.order("created_at DESC")
  end

  def slug
    self.title.downcase.gsub(" ","-")    
  end
end
