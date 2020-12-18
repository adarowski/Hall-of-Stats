class SeasonStats < ActiveRecord::Base
  # attr_accessible :player_id, :waa_pos, :war_pos, :waa_p, :war_p, :waa_tot, :war_tot, :year,
  #   :team, :franchise_id, :stint, :lg, :hall_rating,
  #   as: :admin

  validates :player_id, uniqueness: { scope: [:year, :franchise_id] }
  belongs_to :player
  belongs_to :franchise

  def team_and_franchise
    if team.downcase == franchise_id.downcase
      "#{team}"
    else
      "#{team} <small>(#{franchise_id})</small>"
    end.upcase.html_safe
  end
end
