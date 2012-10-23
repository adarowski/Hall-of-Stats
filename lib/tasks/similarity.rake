namespace :similarity do
  desc 'Generate similarity scores for players matching given criteria, based on given algorithm. Run with TEST=true to only calculate for a subset of users (around 1550).'
  task :generate => :environment do
    ActiveRecord::Base.connection.execute "delete from similarity_scores"
    if ENV['TEST'] == 'true'
      players = Player.for_similarity_test
    else
      players = Player.all
    end
    players.each_with_index do |p1, idx|
      print "processing #{p1.name} (#{idx+1}/#{players.size})..."
      players[(idx+1)..-1].each do |p2|
        SimilarityScore.record_similarity(p1, p2)
      end
      puts "Done."
    end
  end

  desc 'Export current similarity table to a spreadsheet.'
  task :export do
  end
end
