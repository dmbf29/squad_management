# puts 'Cleaning DB...'
# Team.destroy_all

# puts 'Getting Admin users...'
# doug = User.find_by(email: 'douglasmberkley@gmail.com') || User.create(email: 'douglasmberkley@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true)
# renato = User.find_by(email: 'renatonato_jr@hotmail.com') || User.create(email: 'renatonato_jr@hotmail.com', password: ENV['ADMIN_PASSWORD'], admin: true)

# puts 'Creating teams...'
# burnley = Team.create!(name: 'Burnley', user: doug)
# watford = Team.create!(name: 'Watford', user: renato)
# puts "... created #{Team.count} teams."

# puts 'Creating squads...'
# burnley_squad = Squad.create!(name: 'Senior', team: burnley)
# burnley_utwenty = Squad.create!(name: 'U23', team: burnley)

# watford_squad = Squad.create!(name: 'Senior', team: watford)
# watford_utwenty = Squad.create!(name: 'U23', team: watford)
# puts "... created #{Squad.count} squads."

# # Burnley Positions
# puts 'Creating spots...'
# [burnley_squad, burnley_utwenty].each do |squad|
#   spots = [
#     { name: 'FW', position: 1, row_number: 1, squad: squad },
#     { name: 'FW', position: 2, row_number: 1, squad: squad },
#     { name: 'GK', position: 3, row_number: 1, squad: squad },
#     { name: 'CAM', position: 1, row_number: 2, squad: squad },
#     { name: 'CM', position: 2, row_number: 2, squad: squad },
#     { name: 'BBM', position: 3, row_number: 2, squad: squad },
#     { name: 'DLP', position: 4, row_number: 2, squad: squad },
#     { name: 'LB', position: 1, row_number: 3, squad: squad },
#     { name: 'CB', position: 2, row_number: 3, squad: squad },
#     { name: 'CB', position: 3, row_number: 3, squad: squad },
#     { name: 'RB', position: 4, row_number: 3, squad: squad },
#   ]
#   Spot.create!(spots)
# end

# # Watford Positions
# [watford_squad, watford_utwenty].each do |squad|
#   spots = [
#     { name: 'LW', position: 1, row_number: 1, squad: squad },
#     { name: 'FW', position: 2, row_number: 1, squad: squad },
#     { name: 'RW', position: 3, row_number: 1, squad: squad },
#     { name: 'GK', position: 4, row_number: 1, squad: squad },
#     { name: 'CM', position: 1, row_number: 2, squad: squad },
#     { name: 'CM', position: 2, row_number: 2, squad: squad },
#     { name: 'DM', position: 3, row_number: 2, squad: squad },
#     { name: 'LB', position: 1, row_number: 3, squad: squad },
#     { name: 'CB', position: 2, row_number: 3, squad: squad },
#     { name: 'CB', position: 3, row_number: 3, squad: squad },
#     { name: 'RB', position: 4, row_number: 3, squad: squad },
#   ]
#   Spot.create!(spots)
# end
# puts "... created #{Spot.count} spots."

# http://res.cloudinary.com/dmbf29/image/upload/78pyio19vku20jpbarskk66dulkg
url = "https://res.cloudinary.com/dmbf29/raw/upload/v1675667301/development/78pyio19vku20jpbarskk66dulkg.html"
p ParseHtmlService.new(url: url, squad: Squad.find(13)).call
