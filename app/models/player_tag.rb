# == Schema Information
#
# Table name: player_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :bigint           not null
#  tag_id     :bigint           not null
#
# Indexes
#
#  index_player_tags_on_player_id  (player_id)
#  index_player_tags_on_tag_id     (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => players.id)
#  fk_rails_...  (tag_id => tags.id)
#
class PlayerTag < ApplicationRecord
  belongs_to :tag
  belongs_to :player
end
