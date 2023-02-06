# == Schema Information
#
# Table name: players
#
#  id                     :bigint           not null, primary key
#  age                    :integer
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
  belongs_to :team
  has_many :spot_places, dependent: :destroy
  has_many :spots, through: :spot_places
  has_many :squads, through: :spots
  validates :name, presence: true
end
