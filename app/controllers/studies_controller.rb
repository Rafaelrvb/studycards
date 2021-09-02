class StudiesController < ApplicationController

  def new
    @deck_community = DeckCommunity.find(params[:deck_community_id])
    @cards = @deck_community.deck.cards
  end

  def create
    card = params[:card_id].to_i
    difficulty = params[:grade].to_i/100.0
    deck_community_id = params[:deck_community_id]




    @study = Study.new(user_id: current_user.id, card_id: card, grade: difficulty)
    @study.save

    redirect_to new_study_path(deck_community_id)




  end




end
