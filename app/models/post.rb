class Post < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def slug
    self.title.downcase.gsub(" ","-")    
  end
end
