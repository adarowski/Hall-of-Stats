class AddDanAndDaltonHof < ActiveRecord::Migration
  def change
    add_column :players, :dan_hof, :boolean
    add_column :players, :dalton_hof, :boolean
  end
end
