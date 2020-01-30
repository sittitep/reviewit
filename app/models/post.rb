class Post < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy

  def slug
    self.title.downcase.gsub(" ","-")    
  end
end
