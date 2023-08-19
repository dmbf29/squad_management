class CreateColors < ActiveRecord::Migration[7.0]
  def change
    remove_column :teams, :loan_color, :string
    create_table :colors do |t|
      t.string :name
      t.string :hex

      t.timestamps
    end
    names  = [ "gray",    "red",    "green",   'yellow',  'orange',  'purple',  'blue',    'pink',    'brown']
    colors = ["#DAD2D8", "#EA526F", "#03C7B4", '#F4D58D', '#FA7E61', '#7052b4', '#1E91D6', '#EA9FE3', '#813405']
    colors.each_with_index do |color, index|
      Color.create!(
        name: names[index],
        hex: color
      )
    end
  end
end
