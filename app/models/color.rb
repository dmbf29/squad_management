# == Schema Information
#
# Table name: colors
#
#  id         :bigint           not null, primary key
#  hex        :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Color < ApplicationRecord
  validates :hex, presence: true

  # names  = [ "gray",    "red",    "green",   'yellow',  'orange',  'purple',  'blue',    'pink',    'brown']
  # colors = ["#DAD2D8", "#EA526F", "#03C7B4", '#F4D58D', '#FA7E61', '#7052b4', '#1E91D6', '#EA9FE3', '#813405']

  def self.descriptions(color)
    case color.name
    when 'gray'    then 'Squad Member'
    when 'red'     then 'Need Action'
    when 'green'   then 'Youth'
    when 'yellow'  then 'Incoming'
    when 'orange'  then 'Extra'
    when 'purple'  then 'Out Loan'
    when 'blue'    then 'In Loan'
    when 'pink'    then 'Watch'
    when 'brown'   then 'Disposable'
    end
  end
end
