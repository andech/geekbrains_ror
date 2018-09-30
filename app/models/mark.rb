class Mark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :value, presence: true, inclusion: { in: [*1..5] }
end
