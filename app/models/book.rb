class Book < ApplicationRecord
  has_many :user_books, dependent: :destroy
  has_many :book_categories, dependent: :destroy
  has_many :buy_requests, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :users, through: :user_books
  has_many :categories, through: :book_categories

  scope :alpha, ->{order title: :desc}
  scope :search_for_title, ->(text){where("title LIKE ?", "%#{text}%") if text.present?}
  scope :search_for_author, ->(text){where("author LIKE ?", "%#{text}%") if text.present?}
  scope :books_rating,
    ->(star){joins(:reviews).group(:book_id).having("avg(rate) between #{star}-0.5 and #{star}+0.5")}

  def self.search text_search, search_for
    case search_for
    when "Title"
      Book.search_for_title text_search
    when "Author"
      Book.search_for_author text_search
    end
  end
end
