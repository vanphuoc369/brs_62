class UserBooksController < ApplicationController
  before_action :find_book_id

  def create
    if params[:button] == "like"
      @user_book= UserBook.create!(user_id: current_user.id, book_id: params[:book_id], is_favorite: true)
    elsif params[:button] == "read"
      @user_book= UserBook.create!(user_id: current_user.id, book_id: params[:book_id], status: 2)
    else
      @user_book= UserBook.create!(user_id: current_user.id, book_id: params[:book_id], status: 1)
    end
    respond_to do |format|
      format.html {redirect_to @user_book, @book}
      format.js
    end
  end

  def update
    @user_book = UserBook.find_by id: params[:id]
    is_favorite = params[:is_favorite]
    status = params[:status]
    if params[:button] == "like"
      is_favorite = mark_like is_favorite
    else
      status = mark_read status, params[:button]
    end
    @user_book.update(is_favorite: is_favorite, status: status)
    respond_to do |format|
      format.html {redirect_to @user_book, @book}
      format.js
    end
  end

  def find_book_id
    @book = Book.find_by id: params[:book_id]
  end

  private

  def mark_like value_params
    return true if value_params == "false"
    return false
  end

  def mark_read value_params_status, value_params_button
    if value_params_button == "read"
      return 2 if value_params_status != "2"
      return 0
    else
      return 1 if value_params_status != "1"
      return 0
    end
  end
end
