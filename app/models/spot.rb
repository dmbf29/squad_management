# == Schema Information
#
# Table name: spots
#
#  id         :bigint           not null, primary key
#  name       :string
#  position   :integer
#  row_number :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  squad_id   :bigint           not null
#
# Indexes
#
#  index_spots_on_squad_id  (squad_id)
#
# Foreign Keys
#
#  fk_rails_...  (squad_id => squads.id)
#
class Spot < ApplicationRecord
  belongs_to :squad
  has_many :spot_places, dependent: :destroy
  has_many :players, through: :spot_places
  validates :position, presence: true, uniqueness: { scope: [:squad, :row_number] }
  validates :row_number, presence: true
  validates :name, presence: true
end
