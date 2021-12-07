class UpcomingController < ApplicationController

  def index
    @bbwaa_2022_returning = Player.bbwaa_2022_returning.by_rank
    @eligible_2022 = Player.eligible_2022.by_rank
    @eligible_2023 = Player.eligible_2023.by_rank
    @eligible_2024 = Player.eligible_2024.by_rank
    @eligible_2025 = Player.eligible_2025.by_rank
    @eligible_2026 = Player.eligible_2026.by_rank
    @eligible_2027 = Player.eligible_2027.by_rank
    @tg_era_2023 = Player.tg_era_2023.by_rank
    @mb_era_2024 = Player.mb_era_2024.by_rank
    @tg_era_2025 = Player.tg_era_2025.by_rank
    @gd_era_2027 = Player.gd_era_2027.by_rank
    @tg_era_2028 = Player.tg_era_2028.by_rank
    @tg_era_2030 = Player.tg_era_2030.by_rank
    @eb_era_2032 = Player.eb_era_2032.by_rank
  end

end
