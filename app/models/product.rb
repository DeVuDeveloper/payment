class Product < ApplicationRecord
  has_many :orderables
  has_many :carts, through: :orderables
  has_one_attached :image

  broadcasts_to ->(product) { "products" }, inserts_by: :prepend
  scope :ordered, -> { order(id: :desc) }
end
