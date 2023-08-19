class CreateChosenColors < ActiveRecord::Migration[7.0]
  def change
    create_table :chosen_colors do |t|
      t.string :description
      t.boolean :loan, default: false
      t.references :team, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true

      t.timestamps
    end
  end
end
