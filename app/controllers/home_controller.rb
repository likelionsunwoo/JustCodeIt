require 'nokogiri'
require 'open-uri'

class HomeController < ApplicationController
  def index
    @books = Book.where(genre: "소설").all
  end
  
  def liberalhistory
    @books = Book.where(genre: ["인문", "역사"]).all
  end
  
  def improve
    @books = Book.where(genre: "자기계발").all
  end
  
  def artreligion
    @books = Book.where(genre: "예술/종교").all
  end
  
  def itcomputer
    @books = Book.where(genre: "IT").all
  end
  
  def allgenre
    @books = Book.all
  end
  
  def search
        query = params[:query]
        if query.nil?
            flash[:error] = "검색어를 입력하세요."
        else
            if query.length == 0
                flash[:error] = "검색어를 입력하세요."
                return
            end

            splited = query.split
            @searched_by_author = Array.new
            @searched_by_name = Array.new

            Book.all.each do |s|
                splited.each do |q|
                    @searched_by_author << s if s.author.include?(q)
                    @searched_by_name << s if s.name.include?(q)
                  
                end
            end
            
            @searched_by_author = @searched_by_author.uniq
            @searched_by_name = @searched_by_name.uniq
           
        end
        
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
 
  def reply #댓글입력
    
  end
  
  def search #도서 검색 
    
  end
  
  def buy #도서구매
    
  end 
  
  def add # 장바구니에 더하기
  
  end
  
  # def crawl  #여기서 개조해서 이걸 실제로 쓸꺼임
  #     1.upto(3131) do |c|
  #     doc = Nokogiri::HTML(open("http://nstore.naver.com/ebook/categoryProductList.nhn?categoryTypeCode=all&page=#{c}")) 
  #     # class = lst_list인것 중에 class가 cont인거에서 a태그안에 href안에 있는 페이지를 열고 거기서 cover author name etc..다긁는다.
      
      
      
  #       b = Book.new
  #       b.cover = x
  #       b.save

  #     end
    
    
  #   redirect_to "/home/try" 
  # end
  
  def qualify
    status = false
    token = params[:token] 
    unless token.nil?
      status = true
    end
    return render json: {status: status}
  end
    
    
  
  
  
    
  
  
  # def crawl 이건 리디북스 안쓸꺼임 아마
 
      
  #   211005246.downto(211005240) do |c|
  #     doc = Nokogiri::HTML(open("http://ridibooks.com/v2/Detail?id=#{c}")) 
  #     doc.css("img.thumbnail").each do |x|
      
      
  #       b = Book.new
  #       b.cover = x
  #       b.save

  #     end
  #   end
    
  #   redirect_to "/home/try" 
  # end
  
  
  
  
  
  def crawl #섭서버 500에러 때문에 못씀 그치만 일단 그거 빼면 잘됨 
  
    start_point = 2527000
    start_point = Book.last.bookNum - 1   unless Book.count == 0
    
    start_point.downto(1) do |c|
      puts "\n\n\n\n\t\t#{c}\n\n\n\n\n"
      uri = "http://nstore.naver.com/ebook/detail.nhn?productNo=#{c}"
      doc = Nokogiri::HTML(Net::HTTP.get(URI(uri)))
      
      # => Elements extract|control block
      name    = doc.css(".end_head//h2").inner_text
      cover   = doc.css(".pic_area//img")[0]
      genre   = doc.css("li.info_lst//ul//li:nth-child(3)//a").inner_text
      author  = doc.css("li.info_lst//ul//li:nth-child(1)//a").inner_text
      bookNum = c
      
      # => Book record create block
      unless name == "" || name.nil? || cover.nil?
        b = Book.new
        b.name    = name          unless name == ""                                     # 책제목 class end_head에서 h2 내부 내용
        b.cover   = cover["src"]  unless cover.nil?                                     # 표지이미지
        b.genre   = genre         unless genre == ""                                    # 장르 
        b.author  = author        unless author == ""                                   # 작가
        b.bookNum = bookNum
        # b.isbn    = doc.css("")                                                       # ISBN
        b.save
      end
    end
    
    # => Render|redirect block
    redirect_to "/home/try"
  end



# def crawl #섭서버 500에러 때문에 못씀 그치만 일단 그거 빼면 잘됨 
 
      
#     2524930.downto(1) do |c|
      
#       doc = Nokogiri::HTML(open("http://nstore.naver.com/ebook/detail.nhn?productNo=#{c}")) 
#       res = Net::HTTP.get_response(URI.parse("http://nstore.naver.com/ebook/detail.nhn?productNo=#{c}"))
        
#         if res.code.to_i >= 200 && res.code.to_i < 400 #good codes will be betweem 200 - 399
#           # do something with the url
#           b = Book.new
#           b.name   = doc.css(".end_head//h2").inner_text #책제목 class end_head에서 h2 내부 내용
#           b.cover  = doc.css(".pic_area//img")[0]["src"] #표지이미지
#           b.genre  = doc.css("li.info_lst//ul//li:nth-child(3)//a").inner_text #장르 
#           b.author = doc.css("li.info_lst//ul//li:nth-child(1)//a").inner_text #작가
#           # b.isbn   = doc.css("") #ISBN
#           b.save
#         else
           
#           next
#         end
        
#     end
    
#     redirect_to "/home/try"
# end
    
  
  
  
  
  # def self.crawl
    
  #     arr = []
  #     doc = Nokogiri::HTML(open("http://ridibooks.com/v2/Detail?id=211005246"))
  #     tn = doc.css("img.thumbnail")[0]["src"]
      
  #     return tn
      
  # end
  
  
  
 
 
  # def self.crawl  #네이버북스 한개 콘솔로찍기 낯개 크롤
    
  #     arr = []
  #     doc = Nokogiri::HTML(open("http://nstore.naver.com/ebook/detail.nhn?productNo=2516701"))
  #     tn = doc.css(".pic_area//img")[0]["src"]
      
      
  #     return tn
      
  # end
  
  
  def try
    # hc = HomeController.new
    # k = hc.crawl
    @books = Book.all
  end
    
  def read
    @books = Book.all
    
    
  end

end






