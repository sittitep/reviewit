class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :post, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
