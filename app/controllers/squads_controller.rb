class SquadsController < ApplicationController
  before_action :set_squad, only: [:show, :import, :empty, :update, :destroy, :import_results, :transfers, :duplicate]
  before_action :load_import_vars, only: :import_results
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

  def import_results
    render :import
  end

  def import
    @squad.update(squad_params)
    if @squad.uploads.attached?
      flash[:notice] = "Players imported from HTML"
      load_import_vars
      # √ return players from html
      # √ show which spot they'll be placed in
      # allow to choose stars there? (hard)
      # show players in squad that weren't in the html
      # show players in team but on another squad
      # players on loan / players no longer on loan
      render :import, status: :created
    else
      flash[:alert] = "Sorry something went wrong"
      redirect_to squad_path(@squad)
    end
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

  def transfers
    @team = @squad.team
    @new_squad = Squad.new
    @grouped_players = @squad.players.where.not(join_date: nil).group_by { |player| player.join_date.month >= 6 ? player.join_date.year : player.join_date.year - 1 }.sort_by { |year, _players| -year }
  end

  def duplicate
    @new_squad = @squad.deep_clone include: { spots: :spot_places }
    @new_squad.name = params[:squad][:name]
    @new_squad.save
    redirect_to squad_path(@new_squad)
  end

  private

  def set_squad
    # @squad = Squad.includes([:spots]).find(params[:id])
    @squad = Squad.includes(spots: { spot_places: :player }, players: :tags).find(params[:id])
  end

  def squad_params
    params.require(:squad).permit(:uploads, :name, :total_rows, :team_id, spots_attributes: [:name, :position_id, :row_number, :rank, :_destroy])
  end

  def load_import_vars
    @imported_players = ParseHtmlService.new(team: @squad.team, url: @squad.last_upload_url, incoming: params[:incoming] == 'true').call
    # Players imported but on other squads
    # This doesn't work 👇
    @duplicates = @squad.team.players.where(id: @imported_players).where.not(id: @squad.players)
    # Players that need squad place
    @unconfirmed_players = @squad.team.players.where.missing(:spot_places)
    # Players previously imported and also being imported
    @imported_spot_places = @squad.spot_places.where(player: @imported_players)
    # Players previously imported but missing from currently import
    @missing_spot_places = @squad.spot_places.where.not(player: @imported_players)
    # To add players not confirmed
    @spot_place = SpotPlace.new
    @spots = @squad.spots
    @tags = Tag.created_by_app_or_user(current_user)
    @player_tag = PlayerTag.new
  end
end
