class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = current_user
  end
  
  def create
    @user = current_user
    @book = Book.create(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to books_path
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @user = @book.user
  end

  def edit
    unless current_user.id == @book.user_id
      redirect_to books_path
    end
  end
  
  def update
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."  
      redirect_to book_path(@book)
    else
      render :edit
    end
  end
  
  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :body).merge(user_id: current_user.id)
  end
end
