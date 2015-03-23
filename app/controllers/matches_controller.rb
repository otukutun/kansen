class MatchesController < ApplicationController
  def show
    match = Match.find(params[:id])
    render locals: { match: match }
  end
end
