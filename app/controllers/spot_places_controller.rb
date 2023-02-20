class SpotPlacesController < ApplicationController

  def update
    @spot_place = SpotPlace.find(params[:id])
    @spot_place.update(spot_place_params)
    redirect_to squad_path(@spot_place.spot.squad)
  end

  private

  def spot_place_params
    params.require(:spot_place).permit(:squad_id)
  end
end
