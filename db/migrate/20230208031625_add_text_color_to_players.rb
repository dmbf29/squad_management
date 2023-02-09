class AddTextColorToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :text_color, :string
  end
end
