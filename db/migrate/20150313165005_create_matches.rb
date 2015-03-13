class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.string :place
      t.datetime :held_at
      t.integer :flg
      t.integer :home_score
      t.integer :away_score
      t.integer :winner
      t.integer :loser
      t.integer :visitors
      t.integer :league

      t.timestamps null: false
    end
  end
end
