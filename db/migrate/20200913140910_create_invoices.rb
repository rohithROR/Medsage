class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.references :patient, type: :string, null: false
      t.references :order, type: :string, null: false
      t.string :state

      t.timestamps
    end
  end
end
