class CreateMybooks < ActiveRecord::Migration
  def change
    create_table :mybooks do |t|
      t.integer :user_id
      t.integer :book_id
      t.boolean :is_opened


      t.timestamps null: false
    end
  end
end
