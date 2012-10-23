class SimilarityCalculator
  attr_reader :player1, :player2
  def initialize(player1, player2)
    @player1, @player2 = player1, player2
  end

  def score
    runs_bat +
    runs_br +
    runs_dp +
    runs_defense +
    runs_totalpos +
    runs_pitch +
    waa0_tot(8.4) +
    war162_tot(5) +
    ip_outs(0.2) +
    pa(0.05)
  end

  def method_missing(method_name, *arguments, &block)
    if player1.respond_to?(method_name)
      p1_stat = player1.send(method_name) || 0.0
      p2_stat = player2.send(method_name) || 0.0
      (p1_stat - p2_stat).abs * (arguments.first || 1.0)
    else
      super
    end
  end
end
