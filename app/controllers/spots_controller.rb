class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:update_places, :update_all]
  skip_before_action :verify_authenticity_token, only: [:update_places, :update_all]

  def create
    @spot = Spot.new(spot_params)
    @spot.save
    redirect_to squad_path(@spot.squad)
  end

  def update_places
    # Followed this: https://prabinpoudel.com.np/notes/update-multiple-records-at-once-in-rails/
    @spot = Spot.find(params[:id])
    places = params[:places].map { |param| { id: param[:id], rank: param[:rank], spot_id: param[:spot_id] } }
    grouped_places = places.index_by { |user| user[:id] }
    SpotPlace.update(grouped_places.keys, grouped_places.values)
    render json: @spot
  end

  def update_all
    # Followed this: https://prabinpoudel.com.np/notes/update-multiple-records-at-once-in-rails/
    places = params[:spots].map { |param| { id: param[:id], rank: param[:rank], row_number: param[:row_number] } }
    grouped_spots = places.index_by { |user| user[:id] }
    Spot.update(grouped_spots.keys, grouped_spots.values)
    render json: { status: 'updated' }
  end

  def update
    @spot = Spot.find(params[:id])
    @spot.update(spot_params)
    redirect_to spot_path(@spot)
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :row_number, :rank, :position_id, :squad_id)
  end
end
