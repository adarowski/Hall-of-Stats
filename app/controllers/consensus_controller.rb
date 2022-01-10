class ConsensusController < ApplicationController

  def index
    @hof_hos_hom = Player.hof_hos_hom.by_rank
    @hos_hom = Player.hos_hom.by_rank
    @hall_of_consensus_list = Player.hall_of_consensus_list.by_rank
    @only_hof = Player.only_hof.by_rank
    @only_hos = Player.only_hos.by_rank
    @only_hom = Player.only_hom.by_rank
  end

end
