namespace :rankings do
  desc 'Generate per-franchise rankings for player'
  task :franchise => :environment do
    Player.transaction do
      Franchise.all.map(&:id).each do |franchise|
        puts "=== #{franchise.upcase} ==="
        FranchiseRating.where(franchise_id: franchise).order('hall_rating DESC').each_with_index do |fr, idx|
          rating = idx + 1
          puts "  #{rating}"
          player = Player.where(id: fr.player_id).first
          player.update_attributes!({franchise_rankings: player.franchise_rankings.merge(franchise => rating)},
                                   as: :admin)
        end
      end
    end
  end
end
