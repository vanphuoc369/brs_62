class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember_status user
      redirect_to user
    else
      flash.now[:danger] = t ".error_log_in"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to users_path
  end

  private

  def remember_status user
    params[:session][:remember_me] == Settings.sessions.remember ? remember(user) : forget(user)
  end
end
