class PlayersController < ApplicationController

  def create
    @squad = Squad.find(params[:squad_id])
    @player = Player.new(player_create_params)
    @player.team = @squad.team
    if @player.save
      @squad.add_player_in_spot(@player)
      flash[:notice] = "New player added"
    else
      flash[:alert] = "Something went wrong."
    end
    redirect_to squad_path(@squad)
  end

  def update
    @player = Player.find(params[:id])
    @player.update(player_params)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @squad = Squad.find_by(id: params[:squad_id]) || @player.team.squads.first
    @player.destroy
    if params[:remote]
      respond_to do |format|
        # format.turbo_stream { render 'players/destroy', formats: [:js], status: :see_other }
        format.turbo_stream
      end
    else
      redirect_to squad_path(@squad), status: :see_other
    end
  end

  private

  def player_params
    params.require(:player).permit(:text_color, :current_ability, :potential_low, :potential_high, :price_purchased, :price_sold, :join_date, :senior_signing)
  end

  def player_create_params
    params.require(:player).permit(:name, :home_grown_club, :home_grown_nation, :home_grown_date, :on_loan, :positions, :position_id, :age, :transfer_value, :text_color, :current_ability, :potential_low, :potential_high, :price_purchased, :price_sold, :join_date, :senior_signing)
  end
end
