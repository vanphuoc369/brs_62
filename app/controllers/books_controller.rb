class BooksController < ApplicationController
  def index
    if params[:star]
      @books = Book.books_rating(params[:star]).paginate page: params[:page],
        per_page: Settings.books.per_page
      @title_search = t(".search.title_search_rating", star: params[:star])
    elsif params[:search_for] == I18n.t("nav_bar.submit_favorite")
      logged_in_user
      @books = Book.search_for_favorite(session[:user_id]).paginate page: params[:page],
        per_page: Settings.books.per_page
    elsif params[:search].blank?
      @books = Book.alpha.paginate page: params[:page],
        per_page: Settings.books.per_page
      @title_search = t ".all_books"
    else
      @books = Book.search(params[:search], params[:search_for]).paginate page: params[:page],
        per_page: Settings.books.per_page
      @title_search = t(".search.title_search") + "'#{params[:search]}'"
    end
  end

  def book_params
    params.permit :search, :search_for
  end
end
