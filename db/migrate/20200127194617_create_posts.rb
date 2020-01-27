class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'
    
    create_table :posts, id: :uuid do |t|
      t.string :title
      t.string :url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
