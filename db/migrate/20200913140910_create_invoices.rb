class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.references :patient
      t.references :order
      t.string :state

      t.timestamps
    end
  end
end
