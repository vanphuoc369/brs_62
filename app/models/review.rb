class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
end
