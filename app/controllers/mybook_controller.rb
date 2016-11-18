class MybookController < ApplicationController
    def detail
        @book = Book.find(params[:id])
    end
end
