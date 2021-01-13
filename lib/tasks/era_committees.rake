namespace :era_committee do
  desc 'Populate the era committees for players'
  task populate: :environment do
    Player.connection.execute %{
      UPDATE players SET era_committee = NULL;

      WITH era_stats AS (
        SELECT SUM(season_stats.hall_rating) AS rating,
        player_id,
        CASE WHEN year <= 1949 THEN 'early_baseball'
          WHEN year > 1949 AND year <= 1969 THEN 'golden_days'
          WHEN year > 1969 AND year <= 1987 THEN 'modern_baseball'
          ELSE 'todays_game'
          END AS era,
        CASE WHEN year <= 1949 THEN 1
          WHEN year > 1949 AND year <= 1969 THEN 2
          WHEN year > 1969 AND year <= 1987 THEN 3
          ELSE 4
          END AS era_tiebreaker

        FROM season_stats
        JOIN players ON players.id = season_stats.player_id
        WHERE players.eligibility = 'eligible'
        AND players.hof = false
        AND players.hall_rating > 20
        AND players.alt_hof is NULL

        GROUP BY era, era_tiebreaker, player_id
      ),

      ranked AS (
        select *, RANK() OVER (PARTITION BY player_id ORDER BY rating DESC, era_tiebreaker ASC) FROM era_stats
      )

      UPDATE players SET era_committee = era FROM ranked WHERE rank = 1 AND player_id = players.id;
    }
  end
end
