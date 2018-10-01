class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :commentators, through: :comments, source: :user
  has_many :marks, dependent: :destroy
  has_one :seo, as: :seoable, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { maximum: 140, minimum: 2 }
  validates :title, uniqueness: true
  validates :body, presence: true
  validates :body, length: { maximum: 5000, minimum: 2 }
end
