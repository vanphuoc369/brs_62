class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)

  def index
    @users = User.newest.paginate page: params[:page], per_page: Settings.users.page_size
  end

  def new
    @user = User.new
  end

  def show
    list_favorite_books params[:id]
    list_books params[:id], Settings.reading
    list_books params[:id], Settings.read
    if current_user?(@user) || @user.following?(current_user) || current_user.following?(@user)
      @activities = Activity.by_user @user.id
    else
      @activities = Activity.in_public @user.id
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".sign_up_success"
      redirect_to login_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".edit_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :fullname, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".find_danger"
    redirect_to users_path
  end

  def list_favorite_books user_id
    @books = Book.search_for_favorite(user_id)
    if @books.empty?
      @notify_empty = t ".notify_empty"
    end
  end

  def list_books user_id, status
    if status == Settings.reading
      @reading_books = Book.search_for_history(user_id, status)
      @notify_reading_empty = t "users.notify_reading_empty" if @reading_books.empty?
    else
      @read_books = Book.search_for_history(user_id, status)
      @notify_read_empty = t "users.notify_read_empty" if @read_books.empty?
    end
  end
end
