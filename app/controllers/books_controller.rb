class BooksController < ApplicationController
  def index
    @books = Book.alpha.paginate page: params[:page], per_page: Settings.books.per_page
  end
end
