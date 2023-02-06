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
#  positions              :string
#  potential_high         :float            default(0.0)
#  potential_low          :float            default(0.0)
#  price_purchased        :integer
#  price_sold             :integer
#  recommendation         :string
#  release_clause         :integer
#  release_clause_special :integer
#  transfer_value         :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  team_id                :bigint           not null
#
# Indexes
#
#  index_players_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
class Player < ApplicationRecord
  include NumberFormat

  belongs_to :team
  has_many :spot_places, dependent: :destroy
  has_many :spots, through: :spot_places
  has_many :squads, through: :spots
  validates :name, presence: true

  def format_transfer
  end

  # Converting all the FM column names in the corresponding DB colmn
  def self.sanitize_keys(keys)
    keys.map! do |key|
      case key
      when "Age" then :age
      when 'Name' then :name
      when "Position" then :positions
      when "Club" then :club
      when "Transfer Value" then :transfer_value
      end
    end
  end

  # Converting some raw data from FM into a more useful data type
  def self.sanitize_value(player_info)
    # changing "£2.5M - £5.4M" or "£5.4K" to an integer
    player_info[:transfer_value] = format_price(player_info[:transfer_value])
    player_info
  end
end
