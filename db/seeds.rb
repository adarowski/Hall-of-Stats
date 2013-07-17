require 'csv'

Player.transaction do
  puts "Creating Players..."
  CSV.parse(File.open("public/hall-of-stats-new.csv"), headers: true).each_with_index do |row, idx|
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

    record = Player.find_or_initialize_by_id(player['id'])
    record.update_attributes!(player, as: :admin)
  end
  puts "Done creating players"
end

SeasonStats.transaction do
  puts "Creating SeasonStats..."
  CSV.parse(File.open('public/hall-of-stats-franchise-seasons.csv'), headers: true).each_with_index do |row, idx|
    puts idx if idx % 100 == 0
    stats = row.to_hash
    stats.merge!(franchise_id: stats['franchise_id'].downcase)
    record = SeasonStats.new
    record.update_attributes!(stats, as: :admin)
  end
  puts "Done creating season stats"
end

FranchiseRating.transaction do
  puts "Creating FranchiseRatings..."
  CSV.parse(File.open('public/franchise-hall-rating.csv'), headers: true).each_with_index do |row, idx|
    puts idx if idx % 100 == 0
    stats = row.to_hash
    stats['franchise_id'] = stats['franchise_id'].downcase
    record = FranchiseRating.where(player_id: stats['player_id'],
                                   franchise_id: stats['franchise_id']).first_or_initialize
    record.update_attributes!(stats, as: :admin)
  end
  puts "Done creating franchise ratings"
end

if AdminUser.where(email: 'admin@example.com').blank?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end
