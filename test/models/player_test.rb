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
require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
