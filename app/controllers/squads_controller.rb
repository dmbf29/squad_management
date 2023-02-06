class SquadsController < ApplicationController
  before_action :set_squad, only: [:import, :import_players]


  def import
  end

  def import_players
    @squad.update(squad_params)
  end

  private

  def set_squad
    @squad = Squad.find(params[:id])
  end

  def squad_params
    params.require(:squad).permit(:uploads)
  end
end
