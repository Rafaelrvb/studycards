class StudiesController < ApplicationController

  def new
    if DeckCommunity.find(params[:deck_community_id]).user_id == current_user.id
      @deck_community = DeckCommunity.find(params[:deck_community_id])
      cards = @deck_community.deck.cards # array of all cards, needs to change to array of selected cards for the day

      if params[:next_card] # next_card implies that the user have already started studing, otherwise is nil
        @card = cards[params[:next_card].to_i]
      else
        @card = cards[0]
      end

    else
      flash[:alert] = "You dont have this deck in your collection"
      redirect_to deck_community_path(current_user)
    end
  end

  def create
    @deck_community = DeckCommunity.find(params[:deck_community_id])
    cards = @deck_community.deck.cards
    card = cards.find(params[:card_id])
    card_position_in_array = cards.find_index(card)
    @next_card = card_position_in_array + 1
    difficulty = params[:grade].to_i/100.0

    if Study.where(card_id: card).empty?
      @study = Study.new(user_id: current_user.id, card_id: card.id, grade: difficulty)
      @study.save

      if @next_card == cards.length
        flash[:alert] = "Congratulations, you've finished this study session!"
        redirect_to deck_community_path(current_user)
      else
        redirect_to new_study_path(deck_community_id: @deck_community.id, next_card: @next_card)
      end
    else
      @study = Study.where(card_id: card.id)
      total_points = (@study[0].grade * @study[0].repetition) + difficulty
      @study[0].repetition += 1
      grade = (total_points / @study[0].repetition )
      @study[0].grade = grade
      @study[0].save

      if @next_card == cards.length
        flash[:alert] = "Congratulations, you've finished this study session!"
        redirect_to deck_community_path(current_user)
      else
        redirect_to new_study_path(deck_community_id: @deck_community.id, next_card: @next_card)
      end
    end





  end






end
