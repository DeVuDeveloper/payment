class Charge < ApplicationRecord
  belongs_to :user
  validates :amount, :transaction_id, :status, presence: true
end

