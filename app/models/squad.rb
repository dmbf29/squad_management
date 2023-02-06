# == Schema Information
#
# Table name: squads
#
#  id         :bigint           not null, primary key
#  name       :string
#  total_rows :integer          default(3)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_squads_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
class Squad < ApplicationRecord
  belongs_to :team
  has_many :spots, dependent: :destroy
  has_many :spot_places, through: :spots
  has_many :players, through: :spot_places
  validates :name, presence: true
  validates :total_rows, presence: true, numericality: { greater_than: 0, only_integer: true }
end
