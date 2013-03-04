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
          ranking_data = { franchise => { hall_rating: fr.hall_rating, ranking: rating } }
          player.update_attributes!({franchise_rankings: player.franchise_rankings.merge(ranking_data)},
                                   as: :admin)
        end
      end
    end
  end
end
