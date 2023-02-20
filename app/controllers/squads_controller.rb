class SquadsController < ApplicationController
  before_action :set_squad, only: [:show, :import, :empty, :update, :destroy]

  def new
    # Currently not used
    # @team = Team.find(params[:team_id])
    # @squad = Squad.new
    # @squad.spots.build
  end

  def create
    @team = Team.find(params[:team_id])
    @squad = Squad.new(squad_params)
    @squad.team = @team
    if @squad.save
      redirect_to squad_path(@squad)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @spots = @squad.spots.group_by { |spot| spot.row_number }.sort.to_h
    # @spots = @squad.spots.group(:row_number) #.sort.to_h
    @tags = Tag.created_by_app_or_user(current_user)
    @player_tag = PlayerTag.new
    @team = @squad.team
    @new_squad = Squad.new
    @row_number = @spots.any? ? @spots.keys.last + 1 : 1
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

  def empty
    # @squad.players.destroy_all
    Player.where(id: @squad.players).destroy_all
    redirect_to squad_path(@squad), status: :see_other
  end

  def update
    @squad.update(squad_params)
    redirect_to squad_path(@squad)
  end

  def destroy
    @squad.destroy
    redirect_to teams_path
  end

  private

  def set_squad
    @squad = Squad.includes([:spots]).find(params[:id])
  end

  def squad_params
    params.require(:squad).permit(:uploads, :name, :total_rows, :team_id, spots_attributes: [:name, :position_id, :row_number, :rank, :_destroy])
  end
end
