class UserBooksController < ApplicationController
  before_action :find_book
  before_action :logged_in_user

  def create
    if params[:button] == Settings.value_btn_like
      @user_book= UserBook.new(user_id: current_user.id, book_id: @book.id, is_favorite: true)
    elsif params[:button] == Settings.value_btn_read
      @user_book= UserBook.new(user_id: current_user.id, book_id: @book.id, status: Settings.read)
    else
      @user_book= UserBook.new(user_id: current_user.id, book_id: @book.id, status: Settings.reading)
    end
    if @user_book.save
      respond_to do |format|
        format.html {redirect_to @user_book, @book}
        format.js
      end
    else
      flash[:danger] = t ".mark_fail"
      redirect_to book_path(params[:book_id])
    end
  end

  def update
    @user_book = UserBook.find_by id: params[:id]
    is_favorite = params[:is_favorite]
    status = params[:status]
    if params[:button] == Settings.value_btn_like
      is_favorite = mark_like is_favorite
    else
      status = mark_read status, params[:button]
    end
    if @user_book.update_attributes(is_favorite: is_favorite, status: status)
      respond_to do |format|
        format.html {redirect_to @user_book, @book}
        format.js
      end
    else
      flash[:danger] = t ".mark_fail"
      redirect_to book_path(params[:book_id])
    end
  end

  private

  def find_book
    @book = Book.find_by id: params[:book_id]
    unless @book
      flash[:danger] = t ".not_found_book"
      redirect_to root_path
    end
  end

  def mark_like value_params
    return value_params == Settings.not_favorite
    false
  end

  def mark_read value_params_status, value_params_button
    if value_params_button == Settings.value_btn_read
      value_params_status != Settings.value_btn_read ? :read : :no_mark
    else
      value_params_status != Settings.value_btn_reading ? :reading : :no_mark
    end
  end
end
