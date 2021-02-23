class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.integer  :likeable_id
      t.string   :likeable_type
      t.boolean  :status
      t.timestamps
    end
    add_index :likes, [:likeable_type, :likeable_id]
  end
end
