class SimilarityScore < ActiveRecord::Base
  # attr_accessible :player1_id, :player2_id, :score

  self.primary_key = :player1_id

  has_and_belongs_to_many :player1s, class_name: 'Player'
  has_and_belongs_to_many :player2s, class_name: 'Player'

  scope :for_player, lambda {|player|
    where('player1_id = :player_id OR player2_id = :player_id', player_id: player.id).order('score ASC')
  }

  def self.calculator(player1, player2)
    SimilarityCalculator.new(player1, player2).score
  end

  def self.record_similarity(player1, player2)
    unless score_for(player1, player2).present?
      create(player1_id: player1.id, player2_id: player2.id, score: calculator(player1, player2))
    end
  end

  def self.score_for(player1, player2)
    where("(player1_id = :player1_id and player2_id = :player2_id) OR
           (player1_id = :player2_id and player2_id = :player1_id)",
           player1_id: player1.id, player2_id: player2.id).first.try(:score)
  end

  def players
    Player.where(:id => [player1_id, player2_id])
  end
end
