class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :currency, default: '£'
      t.date :current_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
