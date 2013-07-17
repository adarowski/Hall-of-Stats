class AddConsensusField < ActiveRecord::Migration
  def change
    add_column :players, :consensus, :integer
  end
end
