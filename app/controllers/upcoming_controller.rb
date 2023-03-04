class UpcomingController < ApplicationController

  def index
    @bbwaa_2024_returning = Player.bbwaa_2024_returning.by_rank
    @eligible_2024 = Player.eligible_2024.by_rank
    @eligible_2025 = Player.eligible_2025.by_rank
    @eligible_2026 = Player.eligible_2026.by_rank
    @eligible_2027 = Player.eligible_2027.by_rank
    @eligible_2028 = Player.eligible_2028.by_rank
    @contemporary_era_2023 = Player.contemporary_era_2023.by_rank
    @classic_era_2025 = Player.classic_era_2025.by_rank
    @classic_nlb_2025 = Player.classic_nlb_2025.by_mle_rank
    @contemporary_era_2026 = Player.contemporary_era_2026.by_rank
    @contemporary_era_2029 = Player.contemporary_era_2029.by_rank
    @contemporary_era_2032 = Player.contemporary_era_2032.by_rank
  end

end
