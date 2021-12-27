class AddNlbPlayerAttributes < ActiveRecord::Migration
  def change
    add_column :players, :has_mle, :boolean, default: false
    add_column :players, :only_mle, :boolean, default: false
    add_column :players, :mle_rating
    add_column :players, :seamheads_id, :string
  end
end
