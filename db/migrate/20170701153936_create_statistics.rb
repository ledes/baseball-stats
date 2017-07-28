class CreateStatistics < ActiveRecord::Migration[5.0]
  def change
    create_table :statistics do |t|
      t.belongs_to :player, null: false
      t.integer :season, null: false
      t.integer :games
      t.integer :games_started
      t.integer :at_bats, null: false
      t.integer :runs
      t.integer :hits, null: false
      t.integer :doubles, null: false
      t.integer :triples, null: false
      t.integer :home_runs, null: false
      t.integer :rbi, null: false
      t.integer :caught_stealing
      t.integer :sacrifice_hits
      t.integer :sacrifice_flies, null: false
      t.integer :player_errors
      t.integer :pb
      t.integer :walks, null: false
      t.integer :struck_out
      t.integer :hit_by_pitch, null: false
      t.integer :sb, null: false
      t.string :avg
      t.string :ops
    end
  end
end
