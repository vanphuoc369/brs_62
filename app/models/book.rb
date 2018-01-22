class Book < ApplicationRecord
  has_many :user_books, dependent: :destroy
  has_many :book_categories, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :users, through: :user_books
  has_many :categories, through: :book_categories

  scope :alpha, ->{order title: :desc}
  scope :search_for_title, ->(text) do
    where("title LIKE ?", "%#{text}%") if text.present?
  end
  scope :search_for_author, ->(text) do
    where("author LIKE ?", "%#{text}%") if text.present?
  end
  scope :books_rating, ->(star) do
    joins(:reviews).group(:book_id).having("avg(rate) between #{star}-0.5 and #{star}+0.5")
  end
  scope :search_for_favorite, ->(user_id) do
    joins(:user_books).where("user_books.user_id = #{user_id} and user_books.is_favorite = 1") if user_id.present?
  end
  scope :search_for_history, ->(user_id, status) do
    if user_id.present? && status.present?
      joins(:user_books).where("user_books.user_id = #{user_id} and user_books.status = #{status}")
    end
  end

  def self.search text_search, search_for
    if search_for == I18n.t("nav_bar.submit_author")
      Book.search_for_author text_search
    else
      Book.search_for_title text_search
    end
  end
end
