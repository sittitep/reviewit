class CreateContributors < ActiveRecord::Migration[6.0]
  def change
    create_table :contributors do |t|
      t.references :user, null: false, foreign_key: true
      t.references :branch, null: false, foreign_key: true
      t.integer :points, default: 0

      t.timestamps
    end
  end
end
