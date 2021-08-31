class DecksController < ApplicationController

  def index # /search
    @decks = Deck.all
  end

  def show # /deck/:id
    @deck = Deck.find(params[:id])
  end

  def new # /deck/new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.user_id = current_user.id
    @deck.save

    redirect_to root_path
  end

  private

  def deck_params
    params.require(:deck).permit(:title, :description)
  end


end
