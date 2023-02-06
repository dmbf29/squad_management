require 'open-uri'
require 'nokogiri'

class ParseHtmlService
  attr_reader :url, :squad, :players

  def initialize(attrs = {})
    @url = attrs[:url]
    @squad = attrs[:squad]
    @players = @squad.players
    @html_players = []
  end

  def call
    html = URI.open(url)
    doc = Nokogiri::HTML.parse(html, nil, "utf-8")
    @keys = doc.search('table tr').first.text.split("\n\r\n\t").map(&:strip)
    sanitize_keys
    doc.search('table tr')[1..-1].each do |row|
      player_info = {}
      infos = row.text.split("\n\r\n\t").map(&:strip)
      infos.each_with_index do |info, index|
        player_info[keys[index]] = info
      end
      player = players.find_by(name: player_info['Name']) || Player.new
      player.update(player_info)
      # @html_players << player_info
    end
    # @html_players
  end

  def sanitize_keys
  end
end
