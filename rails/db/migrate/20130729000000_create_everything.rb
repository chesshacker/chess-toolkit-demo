class CreateEverything < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer  :zhash, :limit=>8
      t.string   :fen, :limit=>81
      t.string   :comment
      t.integer  :total, :default=>0
      t.integer  :white, :default=>0
      t.integer  :draw, :default=>0
      t.integer  :score
      t.integer  :score_white_best
      t.integer  :score_black_best
      t.integer  :score_theoretical
      t.integer  :white_elo_total, :limit=>8, :default=>0
      t.integer  :black_elo_total, :limit=>8, :default=>0
    end
    add_index :positions, :zhash, :unique => true

    create_table :moves do |t|
      t.string   :san, :limit=>7
      t.integer  :from_position_id
      t.integer  :to_position_id
      t.integer  :total, :default=>0
    end
    add_index :moves, [:to_position_id, :from_position_id], :unique => true
    add_index :moves, :from_position_id

    # TODO -- add foreign key constraints to migration
    # add_foreign_key(:moves, :from_position_id, :positions)
    # add_foreign_key(:moves, :to_position_id, :positions)
  end
end
