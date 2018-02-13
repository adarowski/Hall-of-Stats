class VotingResult < ActiveRecord::Base
  attr_accessible :player_id, :year, :vote_type, :ballots, :votes, :pct, :inducted, :dropped,
    as: :admin

  belongs_to :player

  scope :chronological, ->{ order(:year) }

  scope :by_vote_type, ->{ order("
  CASE WHEN vote_type = 'nominating-vote' then 1
  WHEN vote_type = 'final-ballot' then 2
  WHEN vote_type = 'run-off' then 3
  ELSE 0
  END")}

  def display_classes
    [
      "yr-#{self.year}-#{self.vote_type}",
      (self.inducted? ? "inducted" : nil),
      (self.dropped? ? "fell-off" : nil)
    ].compact.join(" ")
  end

  def irregular_vote_type?
    self.vote_type != "bbwaa"
  end

  def humanized_vote_type
    case self.vote_type
    when "final-ballot" then "Final Vote"
    when "nominating-vote" then "Nominating Vote"
    when "run-off" then "Run-Off"
    else nil
    end
  end
end
