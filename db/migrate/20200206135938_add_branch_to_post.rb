class AddBranchToPost < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :branch, null: false, foreign_key: true
  end
end
