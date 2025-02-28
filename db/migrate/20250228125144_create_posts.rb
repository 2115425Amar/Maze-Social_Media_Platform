class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.boolean :public

      t.timestamps
    end
  end
end
