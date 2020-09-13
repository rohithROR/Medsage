class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :patient_id
      t.string :order_id
      t.string :state

      t.timestamps
    end
  end
end
