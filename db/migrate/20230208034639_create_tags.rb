class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :abbrev
      t.string :name
      t.string :color
      t.string :font_awesome
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
