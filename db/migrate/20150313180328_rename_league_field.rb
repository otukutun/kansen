class RenameLeagueField < ActiveRecord::Migration
  def change
    rename_column :matches, :league, :league_id
  end
end
