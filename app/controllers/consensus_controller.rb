class ConsensusController < ApplicationController

  def index
    @hof_hos_hom = Player.hof_hos_hom.by_rank
    @hos_hom = Player.hos_hom.by_rank
    @hos_hom_nlb = Player.hos_hom_nlb.by_mle_rank
    @hall_of_consensus_list = Player.hall_of_consensus_list.by_rank
    @hall_of_consensus_nlb_list = Player.hall_of_consensus_nlb_list.by_mle_rank
    @only_hof = Player.only_hof.by_rank
    @only_hos = Player.only_hos.by_rank
    @only_hom = Player.only_hom.by_rank
    @only_nlb_hof = Player.only_nlb_hof.by_mle_rank
    @only_nlb_hos = Player.only_nlb_hos.by_mle_rank
    @only_nlb_hom = Player.only_nlb_hom.by_mle_rank
  end

end
