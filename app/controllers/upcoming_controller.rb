class UpcomingController < ApplicationController

  def index
    @bbwaa_2017_returning = Player.bbwaa_2017_returning.by_rank
    @eligible_2017 = Player.eligible_2017.by_rank
    @eligible_2018 = Player.eligible_2018.by_rank
    @eligible_2019 = Player.eligible_2019.by_rank
    @eligible_2020 = Player.eligible_2020.by_rank
    @eligible_2021 = Player.eligible_2021.by_rank
    @eligible_2022 = Player.eligible_2022.by_rank
    @tg_era_2017 = Player.tg_era_2017.by_rank
    @mb_era_2018 = Player.mb_era_2018.by_rank
    @tg_era_2019 = Player.tg_era_2019.by_rank
    @mb_era_2020 = Player.mb_era_2020.by_rank
    @gd_era_2021 = Player.gd_era_2021.by_rank
    @eb_era_2021 = Player.eb_era_2021.by_rank
    @tg_era_2022 = Player.tg_era_2022.by_rank
    @tg_era_2024 = Player.tg_era_2024.by_rank
    @tg_era_2027 = Player.tg_era_2027.by_rank
  end

end
