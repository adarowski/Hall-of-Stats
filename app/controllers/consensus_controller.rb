class ConsensusController < ApplicationController

  def index
    @hall_of_consensus = Player.hall_of_consensus.by_rank
    @hall_of_consensus_list = Player.hall_of_consensus_list.by_rank
    @all_but_hof = Player.all_but_hof.by_rank
    @all_but_hos = Player.all_but_hos.by_rank
    @only_hof = Player.only_hof.by_rank
    @only_hos = Player.only_hos.by_rank
    @only_hom = Player.only_hom.by_rank
    @only_adam = Player.only_adam.by_rank
    @only_ross = Player.only_ross.by_rank
    @only_bryan = Player.only_bryan.by_rank
    @all_but_adam = Player.all_but_adam.by_rank
    @all_but_ross = Player.all_but_ross.by_rank
    @all_but_bryan = Player.all_but_bryan.by_rank
  end

end
