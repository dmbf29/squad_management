class ChangePositionToRankInSpotPlaces < ActiveRecord::Migration[7.0]
  def change
    remove_column :spot_places, :position, :integer
    add_column :spot_places, :rank, :integer
  end
end
