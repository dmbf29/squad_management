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
  has_many :chosen_colors
  has_many :colors, through: :chosen_colors
  validates :name, presence: true
  accepts_nested_attributes_for :squads, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true
  after_create :add_colors

  def add_colors
    Color.find_each do |color|
      description = Color.descriptions(color)
      ChosenColor.create(
        team: self,
        color: color,
        description: description,
        loan: color.name == 'purple',
        incoming: color.name == 'yellow'
      )
    end
  end

  def loan_color
    chosen_colors.find_by(loan: true)
  end

  def incoming_color
    chosen_colors.find_by(incoming: true)
  end
end
