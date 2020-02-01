class AddFieldsToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :resolved_at, :timestamp
    add_column :posts, :closed_at, :timestamp
    add_column :posts, :deleted_at, :timestamp
  end
end
