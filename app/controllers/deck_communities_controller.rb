class DeckCommunitiesController < ApplicationController
  def index
  end

  def show
    @deck_community = DeckCommunity.where(user: current_user)
  end

  def new
  end

  def create
    @deck = Deck.find(params[:id])
    @deck_community = DeckCommunity.new(deck_id: @deck.id, user_id: current_user.id)
    # if @deck_community.where(deck_id: @deck.id, user_id: current_user.id)


    if @deck_community.save
      redirect_to search_path
    else
      flash[:alert] = "Deck community couldn´t be create, try again"
    end
  end

  def destroy
    @deck_community = DeckCommunity.find(params[:id])
    @deck_community.destroy
    redirect_to deck_community_path(current_user)
  end


end
