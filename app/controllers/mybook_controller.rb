class MybookController < ApplicationController
    def detail
        @book = Book.find(params[:id])
    end
    
    def increase_count
       @book = Book.find(params[:id]) 
       @book.read_count += 1
       @book.save
       
       redirect_to :back
    end
     
    
end
