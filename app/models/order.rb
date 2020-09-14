class Order < ApplicationRecord
  self.primary_key = :order_id
  has_many :invoices
  has_many :patients,  through: :invoices
  scope :active_orders, -> { where(state: 'active') }
end
