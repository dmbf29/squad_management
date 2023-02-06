class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.boolean :home_grown_nation
      t.boolean :home_grown_club
      t.date :home_grown_date
      t.boolean :on_loan
      t.string :positions
      t.float :current_ability
      t.float :potential_low
      t.float :potential_high
      t.integer :age
      t.integer :transfer_value
      t.string :media_desc
      t.integer :release_clause
      t.integer :release_clause_special
      t.string :recommendation
      t.string :nationality
      t.references :team, null: false, foreign_key: true
      t.integer :price_purchased
      t.integer :price_sold

      t.timestamps
    end
  end
end
