class CreateObservationsTable < ActiveRecord::Migration
  def change
    create_table :observations_tables do |t|
      t.integer :user_id
      t.integer :match_id
    end
  end
end
