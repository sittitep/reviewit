class Moderator < ApplicationRecord
  belongs_to :branch
  belongs_to :user

  delegate :name, :email, :avatar_url, :profile_url, to: :user
end
