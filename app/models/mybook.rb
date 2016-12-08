class Mybook < ActiveRecord::Base
    belongs_to :user
    belongs_to :book
    
    def genre
        self.book.genre
    end
end
