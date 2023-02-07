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
end
