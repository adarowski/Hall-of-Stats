class AddBryanHofField < ActiveRecord::Migration
  def change
    add_column :players, :bryan_hof, :boolean
  end
end
