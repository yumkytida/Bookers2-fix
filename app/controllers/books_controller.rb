class BooksController < ApplicationController
  before_action :authenticate_user!
  def new
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to book_path(@book), notice: 'successfully'
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
  	@books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
  	@book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def edit
  	@book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to books_path
    end
  end

  def update
  	@book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'successfully'
    else
      render :edit
    end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
