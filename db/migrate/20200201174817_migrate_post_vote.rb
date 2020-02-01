class MigratePostVote < ActiveRecord::Migration[6.0]
  def up
    ActiveRecord::Base.transaction do
      Vote.find_each do |vote|
        vote.originator_type = "Post"
        vote.originator_id = vote.post_id
        vote.save
      end
    end
  end

  def change
    remove_column :votes, :post_id, :integer
  end
end
