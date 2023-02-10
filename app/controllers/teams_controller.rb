class TeamsController < ApplicationController
  def index
    @teams = current_user.teams
    @squad = Squad.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    if @team.save
      flash[:alert] = 'Create a squad for this team'
      redirect_to new_team_squad_path(@team)
    else
      flash[:alert] = 'Sorry something went wrong.'
      redirect_to teams_path
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :currency, :current_date)
  end
end
