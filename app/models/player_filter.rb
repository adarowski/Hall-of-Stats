module PlayerFilter

  def self.filters_for(player)
    @player = player
    [
      position,
      hof,
      hos,
      hom,
      upcoming,
      active_and_worthy,
      active_and_close,
      near_miss
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

  def self.hom
    @player.hom ? 'hom' : 'not-hom'
  end

  def self.upcoming
    rating_above?(100) && not_hos? && !@player.hof && @player.eligibility == 'upcoming' ? 'upcoming' : nil
  end

  def self.active_and_worthy
    active? && rating_above?(100) && not_hos? ? 'active-and-worthy' : nil
  end

  def self.active_and_close
    'active-and-close' if @player.active_and_close?
  end

  def self.near_miss
    'near-miss' if @player.near_miss?
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
