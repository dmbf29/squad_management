class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.boolean :home_grown_nation, default: false
      t.boolean :home_grown_club, default: false
      t.date :home_grown_date
      t.boolean :on_loan, default: false
      t.string :playing_time
      t.string :positions
      t.string :position_best
      t.float :current_ability, default: 0
      t.float :potential_low, default: 0
      t.float :potential_high, default: 0
      t.integer :age
      t.integer :transfer_value
      t.string :media_desc
      t.integer :release_clause
      t.integer :release_clause_special
      t.string :recommendation
      t.string :nationality
      t.string :club
      t.references :team, null: false, foreign_key: true
      t.integer :price_purchased
      t.integer :price_sold

      t.timestamps
    end
  end
end
