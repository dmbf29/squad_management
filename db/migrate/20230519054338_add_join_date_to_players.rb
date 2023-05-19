class AddJoinDateToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :join_date, :date
    add_column :players, :senior_signing, :boolean, default: false
  end
end
