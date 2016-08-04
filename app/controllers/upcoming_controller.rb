class UpcomingController < ApplicationController

  def index
    @bbwaa_2017_returning = Player.bbwaa_2017_returning.by_rank
    @bbwaa_2017_new = Player.bbwaa_2017_new.by_rank
    @bbwaa_2018_new = Player.bbwaa_2018_new.by_rank
    @bbwaa_2019_new = Player.bbwaa_2019_new.by_rank
    @bbwaa_2020_new = Player.bbwaa_2020_new.by_rank
    @bbwaa_2021_new = Player.bbwaa_2021_new.by_rank
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
