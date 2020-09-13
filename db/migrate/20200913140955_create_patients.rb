class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :patient_id
      t.string :patient_name
      t.string :state

      t.timestamps
    end
  end
end
