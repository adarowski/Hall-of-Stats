class AddNewFieldsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :first_year, :integer
    add_column :players, :last_year, :integer
    add_column :players, :runs_pitch, :integer
    add_column :players, :img_url, :string
  end
end
