class TeamsController < ApplicationController
  def index
    @teams = current_user.teams
    @squad = Squad.new
    @team = Team.new
    @team.squads.build
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    if @team.save
      flash[:alert] = 'Team and squad created.'
      redirect_to squad_path(@team.squads.first)
    else
      flash[:alert] = 'Sorry something went wrong.'
      redirect_to teams_path
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :currency, :current_date, squads_attributes: [:name, :total_rows, :_destroy])
  end
end
