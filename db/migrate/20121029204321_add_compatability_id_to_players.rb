class AddCompatabilityIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :compatibility_id, :string

    execute "update players set compatibility_id = replace(id, '.', '')"
  end
end
