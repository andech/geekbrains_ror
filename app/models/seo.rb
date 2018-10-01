class Seo < ApplicationRecord
  belongs_to :seoable, polymorphic: true

  validates :title, presence: true
  validates :title, length: { maximum: 200, minimum: 2 }
  validates :keywords, presence: true
  validates :keywords, length: { maximum: 200, minimum: 2 }
  validates :description, presence: true
  validates :description, length: { maximum: 200, minimum: 2 }
end
