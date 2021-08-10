class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_book,only: [:edit]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] ="You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @user = current_user
    # 投稿回数
    @book_today = Book.where(created_at: Date.today.all_day)
    @book_yesterday = Book.where(created_at: 1.day.ago.all_day)
    @book_2 = Book.where(created_at: 2.day.ago.all_day)
    @book_3 = Book.where(created_at: 3.day.ago.all_day)
    @book_4 = Book.where(created_at: 4.day.ago.all_day)
    @book_5 = Book.where(created_at: 5.day.ago.all_day)
    @book_6 = Book.where(created_at: 6.day.ago.all_day)
   
    
    
    @book_week = Book.where(created_at: Date.today.all_week)
    @book_last_week =Book.where(created_at: 7.day.ago.all_week)

    if @book_yesterday.count == 0
      @todays = 0
    else
      @todays = @book_today.count / @book_yesterday.count.to_f * 100
    end

    if @book_last_week.count == 0
      @weeks = 0
    else
      @weeks = @book_week.count / @book_last_week.count.to_f * 100
    end
    
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    impressionist(@book, nil, unique: [:ip_address])
    
    
    
    
  end

  def edit
    @user = current_user
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_book
        @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
end

end
