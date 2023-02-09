class PlayersController < ApplicationController
  def update
    @player = Player.find(params[:id])
    @player.update(player_params)
  end

  def destroy
    @player = Player.find(params[:id])
    @squad = Squad.find_by(id: params[:squad_id]) || @player.team.squads.first
    @player.destroy
    redirect_to squad_path(@squad), status: :see_other
  end

  private

  def player_params
    params.require(:player).permit(:text_color, :current_ability, :potential_low, :potential_high, :price_purchased, :price_sold)
  end
end
