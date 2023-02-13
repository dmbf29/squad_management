# == Schema Information
#
# Table name: teams
#
#  id           :bigint           not null, primary key
#  currency     :string           default("£")
#  current_date :date
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_teams_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Team < ApplicationRecord
  belongs_to :user
  has_many :squads, dependent: :destroy
  has_many :players, dependent: :destroy
  has_many :spots, through: :squads
  validates :name, presence: true
  accepts_nested_attributes_for :squads, reject_if: :all_blank, allow_destroy: true
end
