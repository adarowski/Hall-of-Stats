module PlayerFilter

  def self.filters_for(player)
    @player = player
    [
      position,
      hof,
      hos,
      hom,
      personal_hof,
      ross_hof,
      bryan_hof,
      dan_hof,
      dalton_hof,
      upcoming,
      eligible_2016,
      eligible_2017,
      eligible_2018,
      eligible_2019,
      eligible_2020,
      eligible_2021,
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

  def self.personal_hof
    @player.personal_hof ? 'personal-hof' : 'not-personal-hof'
  end

  def self.ross_hof
    @player.ross_hof ? 'ross-hof' : 'not-ross-hof'
  end

  def self.bryan_hof
    @player.bryan_hof ? 'bryan-hof' : 'not-bryan-hof'
  end

  def self.dan_hof
    @player.dan_hof ? 'dan-hof' : 'not-dan-hof'
  end

  def self.dalton_hof
    @player.dalton_hof ? 'dalton-hof' : 'not-dalton-hof'
  end

  def self.upcoming
    rating_above?(100) && not_hos? && !@player.hof && @player.eligibility == 'upcoming' ? 'upcoming' : nil
  end

  def self.eligible_2016
    rating_above?(20) && @player.last_year == 2010 && @player.eligibility == 'upcoming' ? 'eligible-2016' : nil
  end

  def self.eligible_2017
    rating_above?(20) && @player.last_year == 2011 && @player.eligibility == 'upcoming' ? 'eligible-2017' : nil
  end

  def self.eligible_2018
    rating_above?(20) && @player.last_year == 2012 && @player.eligibility == 'upcoming' ? 'eligible-2018' : nil
  end

  def self.eligible_2019
    rating_above?(20) && @player.last_year == 2013 && @player.eligibility == 'upcoming' ? 'eligible-2019' : nil
  end

  def self.eligible_2020
    rating_above?(20) && @player.last_year == 2014 && @player.eligibility == 'upcoming' ? 'eligible-2020' : nil
  end

  def self.eligible_2021
    rating_above?(20) && @player.last_year == 2015 && @player.eligibility == 'upcoming' ? 'eligible-2021' : nil
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
