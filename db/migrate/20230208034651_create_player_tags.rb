class CreatePlayerTags < ActiveRecord::Migration[7.0]
  def change
    create_table :player_tags do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
