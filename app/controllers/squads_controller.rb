class SquadsController < ApplicationController
  before_action :set_squad, only: [:show, :import, :import_players]

  def show
    @spots = @squad.spots.group_by { |spot| spot.row_number }
  end

  def import
  end

  def import_players
    @squad.update(squad_params)
    if @squad.uploads.attached?
      url = Cloudinary::Utils.cloudinary_url(@squad.uploads.last.key)
      ParseHtmlService.new(squad: @squad, url: url)
    end
  end

  private

  def set_squad
    @squad = Squad.find(params[:id])
  end

  def squad_params
    params.require(:squad).permit(:uploads)
  end
end
