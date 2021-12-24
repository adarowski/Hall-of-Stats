require 'csv'

Player.transaction do
  puts "Creating Players..."
  CSV.parse(File.open("public/hall-of-stats-new.csv", "r:UTF-8"), headers: true).each_with_index do |row, idx|

    puts idx if idx % 100 == 0
    player = row.to_hash

    player['id'] = player.delete('player_id')

    # normalize some data
    player['hos'] = (player['hos'].try(:strip) == '1')
    player['hof'] = (player['hof'].try(:strip) == '1')
    player['hom'] = (player['hom'].try(:strip) == '1')
    player['personal_hof'] = (player['personal_hof'].try(:strip) == '1')
    player['ross_hof'] = (player['ross_hof'].try(:strip) == '1')
    player['bryan_hof'] = (player['bryan_hof'].try(:strip) == '1')

    player['position'] = 'p' if player['position'] == 'rp'

    player.delete('image_url') if player['image_url'].blank?

    record = Player.find_or_initialize_by(id: player['id'])
    record.update_attributes!(player)#, as: :admin)
  end
end
puts "Done creating players"

# SeasonStats.transaction do
#   puts "Creating SeasonStats..."
#   CSV.parse(File.open('public/hall-of-stats-franchise-seasons.csv'), headers: true).each_with_index do |row, idx|
#     puts idx if idx % 100 == 0
#     stats = row.to_hash
#     stats.merge!(franchise_id: stats['franchise_id'].downcase)
#     record = SeasonStats.new
#     record.update_attributes!(stats)
#   end
# end
# puts "Done creating season stats"
#
# FranchiseRating.transaction do
#   puts "Creating FranchiseRatings..."
#   CSV.parse(File.open('public/franchise-hall-rating.csv'), headers: true).each_with_index do |row, idx|
#     puts idx if idx % 100 == 0
#     stats = row.to_hash
#     stats['franchise_id'] = stats['franchise_id'].downcase
#     record = FranchiseRating.where(player_id: stats['player_id'],
#                                    franchise_id: stats['franchise_id']).first_or_initialize
#     record.update_attributes!(stats)
#   end
# end
# puts "Done creating franchise ratings"
#
# VotingResult.transaction do
#   puts "Creating VotingResults..."
#   CSV.parse(File.open("public/hall-of-stats-voting.csv"), headers: true).each_with_index do |row, idx|
#     puts idx if idx % 100 == 0
#
#     results = row.to_hash
#     results["inducted"] = (results["inducted"].try(:strip) == "1")
#     results["dropped"] = (results["dropped"].try(:strip) == "1")
#
#     result = VotingResult.new
#     result.update_attributes!(results)
#   end
# end
# puts "Done creating voting results"
#
# if AdminUser.where(email: 'admin@example.com').blank?
#   AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
# end
