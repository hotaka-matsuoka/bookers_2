class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit] 

  def index
    @users = User.all  
    @book = Book.new   
    @user = current_user 
  end

  def show
    @book = Book.new
    @books = @user.books
  end

  def edit
    unless current_user.id == @user.id
      redirect_to user_path(current_user)
    end
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully." 
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
