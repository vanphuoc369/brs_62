class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessor :remember_token, :reset_token

  has_secure_password
  has_many :user_books, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name, foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name, foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books
  has_many :buy_requests, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email, presence: true, length: {maximum: Settings.email.max_size}
  validates :fullname, presence: true, length: {maximum: Settings.fullname.max_size}

  before_save :downcase_email

  scope :newest, ->{order created_at: :desc}

  private

  def downcase_email
    self.email = email.downcase
  end
end
