class AddLoanColorToTeams < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :loan_color, :string, default: '#7052b4'
  end
end
