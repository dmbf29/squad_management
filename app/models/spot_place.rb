# == Schema Information
#
# Table name: spot_places
#
#  id         :bigint           not null, primary key
#  position   :integer
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
class SpotPlace < ApplicationRecord
  belongs_to :spot
  belongs_to :player
  validates :position, presence: true, uniqueness: { scope: :spot }
  before_commit :check_position

  def check_position
    self.position = spot.spot_places + 1 if position.nil?
  end
end
