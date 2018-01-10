class BooksController < ApplicationController
  def index
    @books = Book.alpha.paginate page: params[:page], per_page: Settings.books.per_page
  end

  def show
    @book = Book.find_by id: params[:id]
    @user_book = UserBook.find_by(book_id: params[:id], user_id: current_user.id) if logged_in?
  end
end
