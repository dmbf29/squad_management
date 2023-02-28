class PlayerTagsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def create
    @player = Player.find(params[:player_id])
    @player_tag = PlayerTag.new(player_tag_params)
    @player_tag.player = @player
    @player_tag.save
    respond_to do |format|
      format.html
      format.json { render partial: "player_tags/destroy", locals: { player_tag: @player_tag, tag: @player_tag.tag, show_desc: false }, formats: [:html] }
    end
  end

  def destroy
    @player_tag = PlayerTag.find(params[:id])
    @player_tag.destroy
    # render_to_string(partial: "player_tags/form", locals: { player: @player_tag.player, player_tag: PlayerTag.new, tag: @player_tag.tag }, formats: [:html] )
    respond_to do |format|
      format.html
      format.json { render partial: "player_tags/form", locals: { player: @player_tag.player, player_tag: PlayerTag.new, tag: @player_tag.tag, show_desc: false }, formats: [:html] }
    end
  end

  private

  def player_tag_params
    params.require(:player_tag).permit(:tag_id)
  end
end
