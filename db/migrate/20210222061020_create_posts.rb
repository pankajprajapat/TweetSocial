class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.text :tweet
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
