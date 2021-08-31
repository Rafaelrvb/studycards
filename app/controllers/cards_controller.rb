class CardsController < ApplicationController

  def index
    @deck = Deck.find(params[:id])
    @cards = Card.where(deck_id: @deck.id)
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    deck = Deck.find(params[:id])
    @card.deck_id = deck.id
    @card.save

    redirect_to new_card_path(params[:id])
  end

  private

  def card_params
    params.require(:card).permit(:front_page, :back_page)
  end
end
