# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :bigint           not null
#
# Indexes
#
#  index_notes_on_player_id  (player_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => players.id)
#
class Note < ApplicationRecord
  belongs_to :player
  validates :content, presence: true
end
