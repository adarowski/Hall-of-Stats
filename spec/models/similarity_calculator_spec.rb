require 'spec_helper'

describe SimilarityCalculator do
  let(:player1) { create :player, runs_bat: 53, pa: 30 }
  let(:player2) { create :player, runs_bat: 89, pa: 20 }
  subject(:calculator) { SimilarityCalculator.new(player1, player2) }

  it { calculator.runs_bat.should == 36 }
  it { calculator.pa(0.05).should == 0.5 }
end
