class AddPositionToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_reference :players, :position, foreign_key: true
  end
end
