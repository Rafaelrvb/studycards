class DecksController < ApplicationController

  def index # /search
    @decks = Deck.all
  end

  def show # /decks/:id
    @deck = Deck.find(params[:id])
  end

  def new # /decks/new
    @deck = Deck.new
    #@card = Card.new
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.user_id = current_user.id
    @deck.save

    redirect_to new_card_path(@deck.id)
  end

  private

  def deck_params
    params.require(:deck).permit(:title, :description)
  end


end
