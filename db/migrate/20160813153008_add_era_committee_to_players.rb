class AddEraCommitteeToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :era_committee, :string
    add_index :players, :era_committee
  end
end
