class Match < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :home_team, class_name: 'Team', shortcuts: %i(name api_name)
  belongs_to_active_hash :away_team, class_name: 'Team', shortcuts: %i(name api_name)
  belongs_to_active_hash :league

  enum flg: %i(plan end)

  validates :home_team_id, presence: true
  validates :away_team_id, presence: true
  validates :flg, presence: true
  validates :league_id, presence: true

  scope :home, ->(home_team_api_name) {
    home_team = Team.find_by_api_name(home_team_api_name)
    where('home_team_id = ?', home_team.id)
  }

  scope :away, ->(away_team_api_name) {
    away_team = Team.find_by_api_name(away_team_api_name)
    where('away_team_id = ?', away_team.id)
  }

  scope :own_league, -> (league_api_name) {
    league = League.find_by_api_name(league_api_name)
    where('league_id = ?', league.id)
  }
end
