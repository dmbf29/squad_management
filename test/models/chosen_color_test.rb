# == Schema Information
#
# Table name: chosen_colors
#
#  id          :bigint           not null, primary key
#  description :string
#  incoming    :boolean          default(FALSE)
#  loan        :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  color_id    :bigint           not null
#  team_id     :bigint           not null
#
# Indexes
#
#  index_chosen_colors_on_color_id  (color_id)
#  index_chosen_colors_on_team_id   (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (color_id => colors.id)
#  fk_rails_...  (team_id => teams.id)
#
require "test_helper"

class ChosenColorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
