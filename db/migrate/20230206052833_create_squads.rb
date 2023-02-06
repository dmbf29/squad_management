class CreateSquads < ActiveRecord::Migration[7.0]
  def change
    create_table :squads do |t|
      t.string :name
      t.integer :total_rows
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
