class Match < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :home_team, class_name: 'Team'
  belongs_to_active_hash :away_team, class_name: 'Team'
  belongs_to_active_hash :league

  validates :home_team_id, presence: true
  validates :away_team_id, presence: true
  validates :flg, presence: true
  validates :league_id, presence: true
end
