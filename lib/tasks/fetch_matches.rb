require 'json'
class Tasks::FetchMatches
  HOST = 'http://labs.s-koichi.info'.freeze
  PATH = '/api/jleague/V2/schedule'.freeze
  class << self
    def schedule(league: 'j1', year: Time.zone.now.year)
      # パラメータ決める
      logger = Logger.new('log/fetch_matches_schedule.log')
      logger.debug 'start fetching match schedule'
      begin
        conn = connect_http
        response = conn.get do |req|
          req.url PATH, {year: year, league: league}
        end
        if response.status == 200
          json = JSON.parse(response.body)
          json['sec'].each do |sec|
            sec['sec'] ||= 'ゼロックス杯'
            sec['match'].each do |m|
              save_schedule(m, year: json['year'], section: sec['sec'], league: json['league']) unless Match.home(m['home']).away(m['away']).own_league(json['league']).where(year: json['year']).present?
              logger.info 'fetching success'
            end
          end
        end
      rescue
        logger.warn 'fetching failed'
      end

      # http コネクションする
      # 例外処理
      # 同じ値があるのか確認
      # 既にある場合はupdate
      # まだ無い場合はcreate
      # 成功時にdbに格納
      # log出力
      # 失敗時、log出力
    end

    def result(league: 'j1', year: Time.zone.now.year)
      logger = Logger.new('log/fetch_matches_result.log')
      logger.debug 'start fetching match result'
      begin
        conn = connect_http
        response = conn.get do |req|
          req.url PATH, {year: year, league: league}
        end
        if response.status == 200
          json = JSON.parse(response.body)
          json['sec'].each do |sec|
            sec['sec'] ||= 'ゼロックス杯'
            sec['match'].each do |m|
              save_result(m, year: json['year'], section: sec['sec'], league: json['league']) if Match.home(m['home']).away(m['away']).own_league(json['league']).where(year: json['year']).present?
              logger.info 'fetching success'
            end
          end
        end
      rescue
        logger.warn 'fetching failed'
      end
    end

    private

    def connect_http
      conn = Faraday.new(url: HOST) do |faraday|
        faraday.request :url_encoded # form-encode POST params
        faraday.response :logger # log requests to STDOUT
        faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
      end
    end

    def save_schedule(match, year: Time.zone.now.year, section: '', league: 'j1-1')
      m = Match.new
      m.home_team = Team.find_by_api_name(match['home'])
      m.away_team = Team.find_by_api_name(match['away'])
      m.flg = match['score'].present? ? 'end' : 'plan'
      m.league = League.find_by_api_name(league)
      m.held_at = Time.zone.parse("#{year} #{match['date']} #{match['kickofftime']}")
      m.year = year
      m.place = match['place'] ||= ''
      m.section = section
      m.save
    end

    def save_result(match, year: Time.zone.now.year, section: '', league: 'j1-1')
      return unless match['score'].present?
      m = Match.home(match['home']).away(match['away']).own_league(league).where(year: year, section: section).first
      home_score, away_score = match['score'].split(/-/) if match['score'].present?
      m.home_score = home_score
      m.away_score = away_score
      m.visitors = match['note'].gsub(/,/, '').to_i
      m.flg = 'end'
      m.save
    end
  end
end
