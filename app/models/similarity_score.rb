class SimilarityScore < ActiveRecord::Base
  attr_accessible :player1_id, :player2_id, :score

  has_and_belongs_to_many :player1s, class_name: 'Player'
  has_and_belongs_to_many :player2s, class_name: 'Player'

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
end
