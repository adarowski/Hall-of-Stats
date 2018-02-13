class VotingResult < ActiveRecord::Base
  attr_accessible :player_id, :year, :vote_type, :ballots, :votes, :pct, :inducted, :dropped,
    as: :admin

  belongs_to :player
end
