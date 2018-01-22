class StaticPagesController < ApplicationController
  def home
    @new_books = Book.new_book
    @home_books = Book.home_books
    if @new_books
      @items_active = @new_books.active_items
      @items = @new_books.items
    else
      redirect_to root_path
    end
  end
end
