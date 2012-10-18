module PlayerFilter

  def self.filters_for(player)
    @player = player
    [
      position,
      hof,
      hos,
      upcoming,
      active_and_worthy
    ].compact
  end

  private

  def self.position
    @player.position
  end

  def self.hof
    @player.hof ? 'hof' : 'not-hof'
  end

  def self.hos
    @player.hos ? 'hos' : 'not-hos'
  end

  def self.upcoming
    rating_above?(100) && not_hos? && !@player.hof && @player.eligibility == 'upcoming' ? 'upcoming' : nil
  end

  def self.active_and_worthy
    active? && rating_above?(100) && not_hos? ? 'active-and-worthy' : nil
  end

  def self.active?
    @player.eligibility == 'active' 
  end

  def self.rating_above?(rating)
    @player.hall_rating > rating
  end

  def self.not_hos?
    !@player.hos
  end
end
