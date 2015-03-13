class Match < ActiveRecord::Base
  extend ActiveHash::Associations
  belongs_to :team, foreign_key: :home_team_id, primary_key: :team_id
  belongs_to :team, foreign_key: :away_team_id, primary_key: :team_id
  belongs_to :league,foreign_key: :league_id

  validates :home_team_id, presence: true
  validates :away_team_id, presence: true
  validates :flg, presence: true
  validates :league_id, presence: true
end
