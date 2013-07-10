class ChangePeakLongevityToFloat < ActiveRecord::Migration
  def change
    change_column :players, :peak_pct, :float
    change_column :players, :longevity_pct, :float
  end
end
