class SpotPlacesController < ApplicationController

  def create
    @spot_place = SpotPlace.new(spot_place_params)
    @spot_place.save
    @spots = @spot_place.spot.squad.spots
    @tags = Tag.created_by_app_or_user(current_user)
    @player_tag = PlayerTag.new
    # rendering turb_stream view
  end

  def update
    @spot_place = SpotPlace.find(params[:id])
    @spot_place.update(spot_place_params)
    # TODO: there are two different ways and this is breaking one of them
    # redirect_to squad_path(@spot_place.spot.squad)
    head :ok
  end

  def import
    @spot_place = SpotPlace.find(params[:id])
    @spot_place.update(spot_place_params)
    @spots = @spot_place.spot.squad.spots
    @tags = Tag.created_by_app_or_user(current_user)
    @player_tag = PlayerTag.new
    # rendering turb_stream view
  end

  private

  def spot_place_params
    params.require(:spot_place).permit(:spot_id, :player_id)
  end
end
