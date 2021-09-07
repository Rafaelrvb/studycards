class DecksController < ApplicationController

  def index # /search
    if params[:query].present?
      @decks = Deck.search_by_title_description(params[:query])
    else
      @decks = Deck.all
    end

  end

  def show # /decks/:id
    @deck = Deck.find(params[:id])
    @review = DeckReview.find_by(user: current_user)
    @reviews = DeckReview.where(deck_id: params[:id])
  end

  def new # /decks/new
    @deck = Deck.new
    #@card = Card.new
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.user_id = current_user.id
    if @deck.save
      DeckCommunity.create(user_id: current_user.id, deck_id: @deck.id)
      redirect_to new_card_path(@deck.id)
    else
      render :new
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:title, :description, :availability)
  end


end
