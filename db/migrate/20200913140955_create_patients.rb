class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients, id: false do |t|
      t.string :patient_id
      t.string :patient_name
      t.string :state
      t.index :patient_id, unique: true

      t.timestamps
    end
  end
end
