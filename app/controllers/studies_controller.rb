class StudiesController < ApplicationController

  def new
    @study = Study.new
    @deck_community = DeckCommunity.find(params[:deck_community_id])
    @cards = @deck_community.deck.cards
  end

  def create
    raise
  end


end
