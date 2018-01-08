class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)

  def index
    @users = User.newest.paginate page: params[:page], per_page: Settings.users.page_size
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".sign_up_success"
      redirect_to @user
    else
      render :new
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
end
