# == Schema Information
#
# Table name: spots
#
#  id          :bigint           not null, primary key
#  name        :string
#  rank        :integer
#  row_number  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  position_id :bigint
#  squad_id    :bigint           not null
#
# Indexes
#
#  index_spots_on_position_id  (position_id)
#  index_spots_on_squad_id     (squad_id)
#
# Foreign Keys
#
#  fk_rails_...  (position_id => positions.id)
#  fk_rails_...  (squad_id => squads.id)
#
require "test_helper"

class SpotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
