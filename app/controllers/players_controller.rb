class PlayersController < ApplicationController
  def update
    @player = Player.find(params[:id])
    @player.update(player_params)
  end

  private

  def player_params
    params.require(:player).permit(:text_color, :current_ability, :potential_low, :potential_high, :price_purchased, :price_sold)
  end
end
