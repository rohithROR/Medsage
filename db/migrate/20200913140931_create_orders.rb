class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders, id: false do |t|
      t.string :order_id
      t.string :category
      t.string :state
      t.index :order_id, unique: true

      t.timestamps
    end
  end
end
