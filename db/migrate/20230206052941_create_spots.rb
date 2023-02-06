class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.string :name
      t.integer :position
      t.integer :row_number
      t.references :squad, null: false, foreign_key: true

      t.timestamps
    end
  end
end
