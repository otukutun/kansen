class Match < ActiveRecord::Base
  extend ActiveHash::Associations
  belongs_to :home_team_id, foreign_key: :team_id
  belongs_to :away_team_id, foreign_key: :team_id
  belongs_to :league_id
  
  validate :home_team_id, presence: true
  validate :away_team_id, presence: true
  validate :flg, presence: true
  validate :league_id, presence: true
end
