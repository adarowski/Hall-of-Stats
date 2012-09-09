class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players, id: false do |t|
      t.string :id
      t.string :first_name
      t.string :last_name
      t.decimal :waa0_tot
      t.decimal :war162_tot
      t.decimal :wwar
      t.decimal :hall_rating
      t.string :position
      t.boolean :hos, default: false
      t.boolean :hof, default: false
      t.string :eligibility
      t.integer :peak_pct
      t.integer :longevity_pct
      t.decimal :runs_bat
      t.decimal :runs_br
      t.decimal :runs_dp
      t.decimal :runs_defense
      t.decimal :runs_totalpos
      t.integer :pa
      t.decimal :war_pos
      t.decimal :war162_pos
      t.decimal :waa_pos
      t.integer :ip_outs
      t.decimal :war_p
      t.decimal :war162_p
      t.decimal :waa_p
      t.decimal :war_tot
      t.decimal :waa_tot

      t.timestamps
    end
    add_index :players, :id, unique: true
  end
end
