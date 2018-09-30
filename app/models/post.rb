class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :title, length: { maximum: 20, minimum: 2 }
  validates :title, uniqueness: true
  validates :body, presence: true
  validates :body, length: { maximum: 5000, minimum: 2 }
end
