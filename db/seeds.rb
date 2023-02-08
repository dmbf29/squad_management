puts 'Cleaning DB...'
Team.destroy_all
Position.destroy_all
Tag.destroy_all

puts 'Getting Admin users...'
doug = User.find_by(email: 'douglasmberkley@gmail.com') || User.create(email: 'douglasmberkley@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true)
renato = User.find_by(email: 'renatonato_jr@hotmail.com') || User.create(email: 'renatonato_jr@hotmail.com', password: ENV['ADMIN_PASSWORD'], admin: true)

puts 'Creating teams...'
burnley = Team.create!(name: 'Burnley', user: doug)
watford = Team.create!(name: 'Watford', user: renato)
puts "... created #{Team.count} teams."

puts 'Creating squads...'
burnley_squad = Squad.create!(name: 'Senior', team: burnley)
burnley_utwenty = Squad.create!(name: 'U23', team: burnley)

watford_squad = Squad.create!(name: 'Senior', team: watford)
watford_utwenty = Squad.create!(name: 'U23', team: watford)
puts "... created #{Squad.count} squads."

puts 'Creating all possible positions'
positions = [
  'GK',
  'D (R)',
  'D (L)',
  'D (C)',
  'WB (R)',
  'WB (L)',
  'DM',
  'M (R)',
  'M (L)',
  'M (C)',
  'AM (R)',
  'AM (L)',
  'AM (C)',
  'ST (C)'
]
positions.each { |position| Position.create!(name: position) }
puts "... created #{Position.count} positions."

# Burnley Positions
puts 'Creating spots...'
[burnley_squad, burnley_utwenty].each do |squad|
  spots = [
    { name: 'FW', rank: 1, row_number: 1, squad: squad, position: Position.find_by(name: 'ST (C)') },
    { name: 'FW', rank: 2, row_number: 1, squad: squad, position: Position.find_by(name: 'ST (C)') },
    { name: 'GK', rank: 3, row_number: 1, squad: squad, position: Position.find_by(name: 'GK') },
    { name: 'CAM', rank: 1, row_number: 2, squad: squad, position: Position.find_by(name: 'AM (C)') },
    { name: 'CM', rank: 2, row_number: 2, squad: squad, position: Position.find_by(name: 'M (C)') },
    { name: 'BBM', rank: 3, row_number: 2, squad: squad, position: Position.find_by(name: 'M (C)') },
    { name: 'DM', rank: 4, row_number: 2, squad: squad, position: Position.find_by(name: 'DM') },
    { name: 'LB', rank: 1, row_number: 3, squad: squad, position: Position.find_by(name: 'D (L)') },
    { name: 'CB', rank: 2, row_number: 3, squad: squad, position: Position.find_by(name: 'D (C)') },
    { name: 'CB', rank: 3, row_number: 3, squad: squad, position: Position.find_by(name: 'D (C)') },
    { name: 'RB', rank: 4, row_number: 3, squad: squad, position: Position.find_by(name: 'D (R)') },
  ]
  Spot.create!(spots)
end

# Watford Positions
[watford_squad, watford_utwenty].each do |squad|
  spots = [
    { name: 'LW', rank: 1, row_number: 1, squad: squad, position: Position.find_by(name: 'AM (L)') },
    { name: 'FW', rank: 2, row_number: 1, squad: squad, position: Position.find_by(name: 'ST (C)') },
    { name: 'RW', rank: 3, row_number: 1, squad: squad, position: Position.find_by(name: 'AM (R)') },
    { name: 'GK', rank: 4, row_number: 1, squad: squad, position: Position.find_by(name: 'GK') },
    { name: 'CM', rank: 1, row_number: 2, squad: squad, position: Position.find_by(name: 'M (C)') },
    { name: 'CM', rank: 2, row_number: 2, squad: squad, position: Position.find_by(name: 'M (C)') },
    { name: 'DM', rank: 3, row_number: 2, squad: squad, position: Position.find_by(name: 'DM') },
    { name: 'LB', rank: 1, row_number: 3, squad: squad, position: Position.find_by(name: 'D (L)') },
    { name: 'CB', rank: 2, row_number: 3, squad: squad, position: Position.find_by(name: 'D (C)') },
    { name: 'CB', rank: 3, row_number: 3, squad: squad, position: Position.find_by(name: 'D (C)') },
    { name: 'RB', rank: 4, row_number: 3, squad: squad, position: Position.find_by(name: 'D (R)') },
  ]
  Spot.create!(spots)
end
puts "... created #{Spot.count} spots."

puts 'Creating tags...'
tags = [
  { abbrev: 'Loa', name: 'Listed for Loan', font_awesome: 'fa-solid fa-repeat', color: '#279AF1' },
  { abbrev: 'Sel', name: 'Listed to Sell', font_awesome: 'fa-solid fa-sack-dollar', color: '#EA526F' },
  { abbrev: 'Yth', name: 'Youth', font_awesome: 'fa-solid fa-seedling', color: '#03C7B4' },
  { abbrev: 'Inc', name: 'Incoming player', font_awesome: 'fa-solid fa-right-to-bracket', color: '#F4D58D' }
]
Tag.create!(tags)
puts "... created #{Tag.count} tags."
