class ChangePositionToRankInSpots < ActiveRecord::Migration[7.0]
  def change
    remove_column :spots, :position, :integer
    add_column :spots, :rank, :integer
  end
end
