# == Schema Information
#
# Table name: players
#
#  id                     :bigint           not null, primary key
#  age                    :integer
#  club                   :string
#  current_ability        :float            default(0.0)
#  home_grown_club        :boolean          default(FALSE)
#  home_grown_date        :date
#  home_grown_nation      :boolean          default(FALSE)
#  media_desc             :string
#  name                   :string
#  nationality            :string
#  on_loan                :boolean          default(FALSE)
#  playing_time           :string
#  positions              :string
#  potential_high         :float            default(0.0)
#  potential_low          :float            default(0.0)
#  price_purchased        :integer
#  price_sold             :integer
#  recommendation         :string
#  release_clause         :integer
#  release_clause_special :integer
#  text_color             :string
#  transfer_value         :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  position_id            :bigint
#  team_id                :bigint           not null
#
# Indexes
#
#  index_players_on_position_id  (position_id)
#  index_players_on_team_id      (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (position_id => positions.id)
#  fk_rails_...  (team_id => teams.id)
#
class Player < ApplicationRecord
  include NumberFormat
  include FmInfoFormat

  belongs_to :team
  belongs_to :position, optional: true
  has_many :spot_places, dependent: :destroy
  has_many :spots, through: :spot_places
  has_many :squads, through: :spots
  has_many :player_tags, dependent: :destroy
  has_many :tags, through: :player_tags
  validates :name, presence: true
  RATINGS = [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]
  COLORS = ["#DAD2D8", "#EA526F", "#279AF1", '#F4D58D', '#FA7E61', '#7052b4']
  UPDATEABLE_HTML_ATTRIBUTES = [
    :home_grown_nation,
    :home_grown_club,
    :home_grown_date,
    :on_loan,
    :playing_time,
    :age,
    :transfer_value,
    :media_desc,
    :release_clause,
    :release_clause_special,
    :recommendation,
    :club,
    :nationality
  ]

  def on_loan_color!
    if on_loan
      self.text_color = team.loan_color
    else
      self.text_color = nil unless COLORS.include?(text_color)
    end
    save
  end
  # Converting all the FM column names in the corresponding DB colmn
  def self.sanitize_keys(keys)
    keys.map! do |key|
      case key
      when "Age" then :age
      when 'Name' then :name
      when "Position" then :positions
      when "Best Pos" then :position
      when "Club" then :club
      when "Transfer Value" then :transfer_value
      when "Min Fee Rls" then :release_clause
      when "Nat" then :nationality
      when "Home Grown Status" then :home_grown_club
      when "Due Date" then :home_grown_date
      when "Rec" then :recommendation
      when "Media Description" then :media_desc
      when "Agreed Playing Time" then :playing_time
      end
    end
  end

  # Converting some raw data from FM into a more useful data type - methods in concerns
  def self.sanitize_value(player_info)
    # changing "£2.5M - £5.4M" or "£5.4K" to an integer
    player_info[:transfer_value] = format_price(player_info[:transfer_value])
    player_info[:release_clause] = format_price(player_info[:release_clause])
    # changing "Trained in nation (15-21)" to a boolean
    player_info[:home_grown_nation] = trained_in_nation(player_info[:home_grown_club])
    player_info[:home_grown_date] = trained_at_date(player_info[:home_grown_date])
    # changing "Trained at club (15-21)" to a boolean
    player_info[:home_grown_club] = trained_at_club(player_info[:home_grown_club])
    player_info[:on_loan] = on_loan(player_info[:playing_time])
    player_info[:position] = find_position(player_info[:position])
    player_info
  end

  def other_team_squads(squad)
    team.squads.where.not(id: squad).includes([:spots])
  end
end
