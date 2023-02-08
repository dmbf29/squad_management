# == Schema Information
#
# Table name: tags
#
#  id           :bigint           not null, primary key
#  abbrev       :string
#  color        :string
#  font_awesome :string
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_tags_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Tag < ApplicationRecord
  belongs_to :user, optional: true
  validates :abbrev, presence: true, length: { minimum: 1, maximum: 3 }
  validates :color, presence: true
  scope :created_by_app_or_user, ->(user) { where(user: nil).or(user.tags) }
end
