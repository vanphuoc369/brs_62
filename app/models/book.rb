class Book < ApplicationRecord
  has_many :user_books, dependent: :destroy
  has_many :book_categories, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :users, through: :user_books
  has_many :categories, through: :book_categories

  validates :title, presence: true
  validates :author, presence: true
  validates :number_of_pages, numericality: {greater_than: Settings.number_of_pages, only_integer: true}
  validates :publish_date, presence: true
  validates :summary, presence: true, length: {minimum: Settings.summary}

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
  scope :newest, ->{order created_at: :desc}
  scope :new_book, ->{order(created_at: :desc).limit(8)}
  scope :items, ->{offset(3).limit(4)}
  scope :active_items, ->{limit(4)}
  scope :home_books, ->{limit(3)}
  scope :popular_books, -> do
    joins(:user_books).where("status != 0").group(:book_id).order("count(book_id)").limit(3)
  end
  scope :most_loved_books, -> do
    joins(:user_books).where("is_favorite = true").group(:book_id).order("count(book_id)").limit(9)
  end

  mount_uploader :image, ImageUploader

  def self.search text_search, search_for
    if search_for == I18n.t("nav_bar.submit_author")
      Book.search_for_author text_search
    else
      Book.search_for_title text_search
    end
  end
end
