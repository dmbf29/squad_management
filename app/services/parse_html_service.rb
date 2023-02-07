require 'open-uri'
require 'nokogiri'

class ParseHtmlService
  attr_reader :url, :squad, :players

  def initialize(attrs = {})
    @url = attrs[:url]
    @squad = attrs[:squad]
    @players = @squad.players
    # @html_players = []
  end

  def call
    # html = URI.open(url)
    html = File.open('/Users/dougberks/Library/Application Support/Sports Interactive/Football Manager 2022/u23s_web3.html').read
    doc = Nokogiri::HTML.parse(html, nil, "utf-8")
    @keys = doc.search('table tr').first.text.split("\n\r\n\t").map(&:strip)
    @keys = Player.sanitize_keys(@keys)
    doc.search('table tr')[1..-1].each do |row|
      create_or_update_player(row)
    end
  end

  def create_or_update_player(row)
    player_info = {}
    infos = row.text.split("\n\r\n\t").map(&:strip)
    infos.each_with_index do |info, index|
      player_info[@keys[index]] = info
    end
    player_info = player_info.delete_if { |key, value| key.nil? }
    player_info = Player.sanitize_value(player_info)
    player_info[:team_id] = squad.team.id
    player = players.find_by(name: player_info[:name])
    player ? player.update(player_info) : Player.create(player_info)
  end
end
