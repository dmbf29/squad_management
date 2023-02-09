class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:update_places]
  skip_before_action :verify_authenticity_token, only: [:update_places]

  def update_places
    # Followed this: https://prabinpoudel.com.np/notes/update-multiple-records-at-once-in-rails/
    @spot = Spot.find(params[:id])
    places = params[:places].map { |param| { id: param[:id], rank: param[:rank], spot_id: param[:spot_id] } }
    grouped_places = places.index_by { |user| user[:id] }
    SpotPlace.update(grouped_places.keys, grouped_places.values)
    render json: @spot
  end

  def update
    @spot = Spot.find(params[:id])
    @spot.update(spot_params)
    redirect_to spot_path(@spot)
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :row_number, :rank, :position_id)
  end
end
