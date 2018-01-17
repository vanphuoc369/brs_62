class BooksController < ApplicationController
  before_action :find_book, only: :show

  def new; end

  def index
    if params[:star]
      search_rating
    elsif params[:search_for] == I18n.t("nav_bar.submit_favorite")
      search_favorite
    elsif params[:search].blank?
      load_books
    else
      search_title_and_author
    end
  end

  def book_params
    params.permit :search, :search_for
  end

  def show
    find_book_mark(params[:id], current_user.id) if logged_in?
    @reviews = @book.reviews.newest
    @reviews = collection_paginate @reviews, params[:page], Settings.books.review_per_page
    if @book.reviews.blank?
      @average = 0
      @count_rate = 0
    else
      @average = @book.reviews.average(:rate).round Settings.round
      @count_rate = @book.reviews.count
    end
  end

  private

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t ".danger"
    redirect_to root_path
  end

  def search_rating
    @books = Book.books_rating params[:star]
    @books = collection_paginate @books, params[:page], Settings.books.per_page
    @title_search = t(".search.title_search_rating", star: params[:star])
  end

  def search_favorite
    logged_in_user
    @books = Book.search_for_favorite session[:user_id]
    @books = collection_paginate @books, params[:page], Settings.books.per_page
  end

  def search_title_and_author
    @books = Book.search params[:search], params[:search_for]
    @books = collection_paginate @books, params[:page], Settings.books.per_page
    @title_search = t(".search.title_search") + "'#{params[:search]}'"
  end

  def load_books
    @books = Book.alpha
    @books = collection_paginate @books, params[:page], Settings.books.per_page
    @title_search = t ".all_books"
  end

  def find_book_mark book_id, user_id
    @user_book = UserBook.find_by book_id: book_id, user_id: user_id
    @notify_user_book = t ".notify_user_book" if @user_book.nil?
  end
end
