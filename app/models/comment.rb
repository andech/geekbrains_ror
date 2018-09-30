class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :body, presence: true
  validates :body, length: { maximum: 200, minimum: 2 }
end
