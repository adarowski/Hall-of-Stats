class AddAdditionalInductionInfo < ActiveRecord::Migration
  def change
    add_column :players, :hof_year, :integer
    add_column :players, :hof_via, :string
  end
end
