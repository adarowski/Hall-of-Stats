class AddCoverModelToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :cover_model, :boolean, default: false
    add_index  :players, :cover_model
  end
end
