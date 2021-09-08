class StudiesController < ApplicationController

  def new
    # selecting deck community if it exists for that user
    if DeckCommunity.find(params[:deck_community_id]).user_id == current_user.id
      @deck_community = DeckCommunity.find(params[:deck_community_id])

      if @deck_community.deck.cards.count.zero?
        flash[:alert] = "You dont have any cards in this deck"
        redirect_to deck_community_path(current_user)
      end
      # creating a session of user progress

      if @deck_community.user_progress.nil?
        @session = UserProgress.create(deck_community_id: @deck_community.id, sessions: 0)
      else
        @session = @deck_community.user_progress
      end

      # creating array of cards to be studied
      cards = @deck_community.deck.cards

      # next_card implies that the user have already started studing, otherwise is nil
      if params[:next_card]
        @card = cards[params[:next_card].to_i]
      else
        @card = cards[0]
      end

    else
      flash[:alert] = "You dont have this deck in your collection"
      redirect_to deck_community_path(current_user)
    end
  end

  def create # should be renamed method 'study'

    # logic for grading the specific studied card and grabbing the next one to be studied
    @deck_community = DeckCommunity.find(params[:deck_community_id])
    cards = @deck_community.deck.cards
    card = cards.find(params[:card_id])
    card_position_in_array = cards.find_index(card)
    @next_card = card_position_in_array + 1
    difficulty = params[:grade].to_i/100.0

    # verifying if the card was already studied before
    if Study.where(card_id: card).empty?
      @study = Study.new(user_id: current_user.id, card_id: card.id, grade: difficulty)
      @study.save

      # redirecting user after completion of a study session
      if @next_card == cards.length
        flash[:alert] = "Congratulations, you've finished this study session!"
        session = UserProgress.find(params[:session])
        session.sessions += 1
        session.save
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

      # redirecting user after completion of a study session
      if @next_card == cards.length
        flash[:alert] = "Congratulations, you've finished this study session!"
        session = UserProgress.find(params[:session])
        session.sessions += 1
        session.save
        redirect_to deck_community_path(current_user)
      else
        redirect_to new_study_path(deck_community_id: @deck_community.id, next_card: @next_card)
      end
    end




  end


end
