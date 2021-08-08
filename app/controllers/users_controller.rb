class UsersController < ApplicationController

  before_action :authenticate_user!


  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end


  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
    # DM機能 start
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomID = cu.room_id
          end
        end
      end
      unless @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    
    
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] ="You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end





  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
