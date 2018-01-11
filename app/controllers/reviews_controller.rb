class ReviewsController < ApplicationController
  before_action :logged_in_user, :find_book, :check_review, only: :create

  def new; end

  def create
    @review = current_user.reviews.build review_params
    if @book.reviews << @review
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to @book
  end

  private

  def find_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t ".danger"
    redirect_to root_path
  end

  def reviewed user_id, book_id
    review = Review.find_by user_id: user_id, book_id: book_id
    return unless review
    flash[:danger] = t ".reivewed"
    redirect_to @book
  end

  def check_review
    reviewed current_user.id, params[:book_id]
  end

  def review_params
    params.require(:review).permit :content, :rate, :book_id
  end
end
