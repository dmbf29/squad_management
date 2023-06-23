require 'open-uri'
require 'nokogiri'

class ParseHtmlService
  attr_reader :url, :team, :players

  def initialize(attrs = {})
    @url = attrs[:url]
    @team = attrs[:team]
    @players = @team.players
    @html_players = []
  end

  def call
    # html = File.open('/Users/dougberks/Library/Application Support/Sports Interactive/Football Manager 2022/u23s_web4.html').read
    html = URI.open(url)
    doc = Nokogiri::HTML.parse(html, nil, "utf-8")
    @keys = doc.search('table tr').first.text.split("\n\r\n\t").map(&:strip)
    @keys = Player.sanitize_keys(@keys)
    doc.search('table tr')[1..-1].each do |row|
      create_or_update_player(row)
    end
    @html_players
  end

  def create_or_update_player(row)
    player_info = {}
    infos = row.text.split("\n\r\n\t").map(&:strip)
    infos.each_with_index do |info, index|
      player_info[@keys[index]] = info
    end
    player_info = player_info.delete_if { |key, value| key.nil? }
    player_info = Player.sanitize_value(player_info)
    player_info[:team_id] = team.id
    player = players.find_by(name: player_info[:name])
    if player
      # TODO: should only update specific attributes
      player_info = player_info.merge(player.dont_overwrite)
      player.update(player_info)
      @html_players << player
    else
      player = Player.create(player_info)
      @html_players << player
      # TODO: should stop doing this
      # squad.add_player_in_spot(player)
    end
    player.on_loan_color! if player.on_loan
    # TODO: add incoming color
  end
end
