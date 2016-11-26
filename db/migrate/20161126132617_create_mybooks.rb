class CreateMybooks < ActiveRecord::Migration
  def change
    create_table :mybooks do |t|
      t.integer :user_id
      t.integer :book_id
      t.boolean :is_opened, default:false
      t.boolean :is_listed, default:false

      t.timestamps null: false
    end
  end
end