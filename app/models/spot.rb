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
class Spot < ApplicationRecord
  belongs_to :squad
  belongs_to :position, optional: true
  has_many :spot_places, dependent: :destroy
  has_many :players, through: :spot_places
  # validates :rank, presence: true, uniqueness: { scope: [:squad, :row_number] }
  validates :row_number, presence: true
  validates :name, presence: true
  before_validation :check_rank

  def check_rank
    self.rank = squad.spots.where(row_number: row_number).count + 1 if rank.nil?
  end
end
