class MostLovedBookController < ApplicationController
  def index
    @most_loved_books = Book.most_loved_books
  end
end
