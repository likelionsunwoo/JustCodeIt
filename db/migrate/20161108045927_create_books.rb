class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      
      t.string  :name
      t.string  :author
      t.string  :genre
      t.string  :isbn
      t.string  :content  # url로 할꺼 이북의  내용
      t.string  :cover    # 표지
      t.integer :bookNum  # Key number for request uri => (uri = "http://nstore.naver.com/ebook/detail.nhn?productNo=#{bookNum}")
      t.integer :read_count, default: 0
      t.timestamps null: false
    end
  end
end
