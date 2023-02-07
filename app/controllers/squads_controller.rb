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
      url = "http://res.cloudinary.com/#{ENV['CLOUDINARY_NAME']}/raw/upload/v1/development/#{@squad.uploads.last.key}.html"
      ParseHtmlService.new(squad: @squad, url: url).call
      flash[:notice] = "Players imported from HTML"
    else
      flash[:alert] = "Sorry something went wrong"
    end
    redirect_to squad_path(@squad)
  end

  private

  def set_squad
    @squad = Squad.find(params[:id])
  end

  def squad_params
    params.require(:squad).permit(:uploads)
  end
end
