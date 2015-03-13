class Match < ActiveRecord::Base
  extend ActiveHash::Associations
  belongs_to :home_team_id, foreign_key: :team_id
  belongs_to :away_team_id, foreign_key: :team_id
  belongs_to :league_id
end
