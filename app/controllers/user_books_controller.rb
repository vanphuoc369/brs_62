  class UserBooksController < ApplicationController
  before_action :find_book
  before_action -> {check_login_or_save_url(book_path @book.id)}

  def create
    if params[:button] == Settings.value_btn_like
      @user_book = UserBook.new(user_id: current_user.id, book_id: @book.id, is_favorite: true)
    elsif params[:button] == Settings.value_btn_read
      @user_book = UserBook.new(user_id: current_user.id, book_id: @book.id, status: Settings.read)
    else
      @user_book = UserBook.new(user_id: current_user.id, book_id: @book.id, status: Settings.reading)
    end
    if @user_book.save
      content, type_activity = new_value_content_and_type_activity
      new_activity current_user, content, @user_book.id, type_activity
      respond_to do |format|
        format.html{redirect_to @user_book, @book}
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
      content, type_activity = active_favorite_book is_favorite
    else
      status, content, type_activity = mark_read status, params[:button]
    end
    if @user_book.update_attributes(is_favorite: is_favorite, status: status)
      new_activity current_user, content, @user_book.id, type_activity
      respond_to do |format|
        format.html{redirect_to @user_book, @book}
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
    return if @book
    flash[:danger] = t ".not_found_book"
    redirect_to root_path
  end

  def mark_like value_params
    value_params == Settings.not_favorite
  end

  def mark_read value_params_status, value_params_button
    if value_params_button == Settings.value_btn_read
      if value_params_status != Settings.value_btn_read
        return :read, (t ".read_book", book: @book.title), Settings.action_read
      else
        return :no_mark,(t ".unread_book", book: @book.title), Settings.action_unread
      end
    else
      if value_params_status != Settings.value_btn_reading
        return :reading, (t ".reading_book", book: @book.title), Settings.action_reading
      else
        return :no_mark, (t ".unreading_book", book: @book.title), Settings.action_unreading
      end
    end
  end

  def active_favorite_book favorite
    if favorite == Settings.favorite_false
      return (t ".unlike_book", book: @book.title), Settings.action_favorite
    else
      return (t ".like_book", book: @book.title), Settings.action_unfavorite
    end
  end

  def new_value_content_and_type_activity
    if params[:button] == Settings.value_btn_like
      return (t ".like_book", book: @book.title), Settings.action_favorite
    elsif params[:button] == Settings.value_btn_read
      return (t ".read_book", book: @book.title), Settings.action_read
    else
      return (t ".reading_book", book: @book.title), Settings.action_reading
    end
  end
end
