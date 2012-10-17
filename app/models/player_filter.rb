module PlayerFilter

  def self.filters_for(player)
    @player = player
    [
      position,
      hof,
      hos,
      upcoming,
      active_but_worthy,
      active_and_close,
      close_call
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
    rating_above?(100) && not_hos? && @player.eligibility == 'upcoming' ? 'upcoming' : nil
  end

  def self.active_but_worthy
    active? && rating_above?(100) && not_hos? ? 'active-but-worthy' : nil
  end

  def self.active_and_close
    active? && rating_above?(80) && not_hos? ? 'active-and-close' : nil
  end

  def self.close_call
    !active? && rating_above?(90) && not_hos? ? 'close-call' : nil
  end

  def self.active?
    @player.eligibility == 'active' 
  end

  def self.rating_above?(rating)
    @player.hall_rating > rating
  end

  #def self.rating_above_and_not_hos?(rating)
  def self.not_hos?
    !@player.hos
  end
end
