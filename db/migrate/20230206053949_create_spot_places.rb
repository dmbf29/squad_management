class CreateSpotPlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :spot_places do |t|
      t.integer :position
      t.references :spot, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
