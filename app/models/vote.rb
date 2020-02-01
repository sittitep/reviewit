class Vote < ApplicationRecord
  belongs_to :originator

  after_create :set_originator_vote_count
  after_update :set_originator_vote_count

  private 

  def set_originator_vote_count
    self.originator.vote_count = self.originator.votes.sum(:value)
    self.originator.save
  end
end
