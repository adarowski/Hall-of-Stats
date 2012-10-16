class AddAltHofToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :alt_hof, :string
  end
end
