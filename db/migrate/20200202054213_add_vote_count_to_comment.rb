class AddVoteCountToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :vote_count, :integer, default: 0
  end
end
