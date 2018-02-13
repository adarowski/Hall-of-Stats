class VotingResult < ActiveRecord::Base
  attr_accessible :player_id, :year, :vote_type, :ballots, :votes, :pct, :inducted, :dropped,
    as: :admin

  belongs_to :player

  scope :chronological, ->{ order(:year) }

  def display_classes
    [
      "yr-#{self.year}",
      (self.inducted? ? "inducted" : nil),
      (self.dropped? ? "fell-off" : nil)
    ].compact.join(" ")
  end
end
