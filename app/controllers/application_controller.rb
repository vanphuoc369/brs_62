class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_popular_books
  include SessionsHelper
  include ReviewsHelper

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def collection_paginate collection, page, per_page
    collection.paginate page: page, per_page: per_page
  end

  def check_login_or_save_url url
    unless logged_in?
      session[:forwarding_url] = url
      flash[:danger] = t "users.index.please_log_in"
      redirect_to login_url
    end
  end

  def load_popular_books
    @popular_books = Book.popular_books
  end

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t ".please_log_in"
    redirect_to login_url
  end

  def new_activity user, content, type_id, type_activity
    user.activities.create!(
      type_id: type_id,
      type_activity: type_activity,
      content_action: content
    )
  end
end
