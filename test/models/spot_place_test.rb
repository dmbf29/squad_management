# == Schema Information
#
# Table name: spot_places
#
#  id         :bigint           not null, primary key
#  rank       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :bigint           not null
#  spot_id    :bigint           not null
#
# Indexes
#
#  index_spot_places_on_player_id  (player_id)
#  index_spot_places_on_spot_id    (spot_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => players.id)
#  fk_rails_...  (spot_id => spots.id)
#
require "test_helper"

class SpotPlaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
