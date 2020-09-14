class Invoice < ApplicationRecord
  belongs_to :patient
  belongs_to :order
  scope :active_invoices, -> { where(state: 'active') }
end
