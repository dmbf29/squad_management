class TeamsController < ApplicationController
  before_action :set_team, only: [:edit, :update, :destroy]

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
      raise
      flash[:alert] = 'Sorry something went wrong.'
      redirect_to teams_path
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to teams_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_path
  end

  private

  def team_params
    params.require(:team).permit(:name, :currency, :current_date, squads_attributes: [:name, :total_rows, :_destroy])
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
