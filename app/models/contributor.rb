class Contributor < ApplicationRecord
  belongs_to :user
  belongs_to :branch

  delegate :name, :email, :avatar_url, :profile_url, to: :user
end
