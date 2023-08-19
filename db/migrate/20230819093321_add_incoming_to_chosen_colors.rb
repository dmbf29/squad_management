class AddIncomingToChosenColors < ActiveRecord::Migration[7.0]
  def change
    add_column :chosen_colors, :incoming, :boolean, default: false
  end
end
