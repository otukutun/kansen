class PagesController < ApplicationController
  def top
    @matches = Match.past_week.presence || Match.before(Time.zone.now).limit(9)
  end
end
