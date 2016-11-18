class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      
      t.string :name
      t.string :author
      t.string :genre
      t.string :isbn
      t.string :content ## url로 할꺼 이북의  내용
      t.string :cover #표지 

      t.timestamps null: false
    end
  end
end
