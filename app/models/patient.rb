class Patient < ApplicationRecord
  self.primary_key = :patient_id
  has_many :invoices
  has_many :orders,  through: :invoices
  scope :active_patients, -> { where(state: 'active') }
end
