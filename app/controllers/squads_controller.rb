class SquadsController < ApplicationController
  before_action :set_squad, only: [:show, :import]

  def show
    @spots = @squad.spots.group_by { |spot| spot.row_number }
  end

  def import
    @squad.update(squad_params)
    if @squad.uploads.attached?
      ParseHtmlService.new(squad: @squad, url: @squad.last_upload_url).call
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
