class StudiesController < ApplicationController

  def new
    @deck_community = DeckCommunity.find(params[:deck_community_id])
    @cards = @deck_community.deck.cards
  end

  def create
    card = params[:card_id].to_i
    difficulty = params[:grade].to_i/100.0
    deck_community_id = params[:deck_community_id]

    if Study.where(card_id: card).empty?
      @study = Study.new(user_id: current_user.id, card_id: card, grade: difficulty)
      @study.save

      redirect_to new_study_path(deck_community_id)
    else
      @study = Study.where(card_id: card)
      total_points = (@study[0].grade * @study[0].repetition) + difficulty
      @study[0].repetition += 1
      grade = (total_points / @study[0].repetition )
      @study[0].grade = grade
      @study[0].save

      redirect_to new_study_path(deck_community_id)
    end

  end




end
