class Widget < ApplicationRecord
  belongs_to :product

  validates :name, presence: true
  validates :product_id, presence: true
end
