class CreateBranches < ActiveRecord::Migration[6.0]
  def change
    create_table :branches do |t|
      t.string :name
      t.string :description
      t.string :slug

      t.timestamps
    end
  end
end
