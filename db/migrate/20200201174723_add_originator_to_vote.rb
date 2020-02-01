class AddOriginatorToVote < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :originator, polymorphic: true, null: false, type: :uuid, index: true
  end
end
