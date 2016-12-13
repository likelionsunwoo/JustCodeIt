class MybookController < ApplicationController
    def detail
        @book = Book.find(params[:id])
        @result = recommend(params[:id])
    end
    
    def pick # 찜 리스트 추가
        #book_id = params[:book_id]
        #user_id = params[:user_id]
        #Mybook.create(user_id: params[:user_id], book_id: params[:book_id], is_opened: false, is_listed: true)
        
        
        if Mybook.where(user_id: current_user.id, book_id: params[:book_id]).count == 0
            
            Mybook.create(user_id: current_user.id, book_id: params[:book_id], is_opened: false, is_listed: true)
        else
            mb = Mybook.where(user_id: current_user.id, book_id: params[:book_id]).take
            mb.is_listed = true
            mb.save
            
        end 
        
        redirect_to :back
        
    end
    
    def read # 읽기 리스트 추가
    
        if Mybook.where(user_id: current_user.id, book_id: params[:book_id]).count == 0
            Mybook.create(user_id: params[:user_id], book_id: params[:book_id], is_opened: true, is_listed: false)
            b = Book.find(params[:book_id])
            b.read_count += 1;
            b.save
        else
            mb = Mybook.where(user_id: current_user.id, book_id: params[:book_id]).take
            mb.is_opened = true
            mb.save
            
            b = Book.find(params[:book_id])
            b.read_count += 1;
            b.save
        end
        
        unless params[:token].nil?
            return render json: {status: true}
        end
        
        redirect_to :back
        
    end
    
    def wish
        #user_id = params[:user_id]
        @mybooks = Mybook.where(user_id: current_user.id, is_listed: true)
        #@mybooks = Mybook.joins("INNER JOIN books b ON b.id = mybooks.book_id and mybooks.is_listed ='t'").where(user_id: current_user.id)
        
    end
    
    def bought
       @mybooks = Mybook.where(user_id: current_user.id, is_opened: true) 
    end
    
    def recommend(id)
      book = Book.find(id)
      my_books = Book.find(id).mybooks
      
      users= my_books.all.map{|m|m.user}
      my_books_total =[]
      my_books_total = users.map{|user|user.mybooks}.flatten
      my_books_total = my_books_total.map{|mybook|mybook.book}.uniq
      my_books_total -= [book]
      result =[]
      my_books_total.each do |b|
          if b.genre == book.genre
              result << b
          end
      end
      return result
    end

end
