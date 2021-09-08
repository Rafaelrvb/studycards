class DeckCommunitiesController < ApplicationController
  def index
  end

  def show
    @deck_community = DeckCommunity.where(user: current_user)
    unless @deck_community.empty?
      @overall_info = overall_info(@deck_community)
      unless @deck_community[params[:var].to_i].user_progress.nil?
        @study_info = study_info(@deck_community[params[:var].to_i])
        @score = score(@study_info).round(2) * 100
        @cards_done = @study_info.select {|study| study.repetition > 0}.count
      end
    end
  end

  def new
  end

  def create
    @deck = Deck.find(params[:id])
    @deck_community = DeckCommunity.new(deck_id: @deck.id, user_id: current_user.id)

    if @deck_community.save
      redirect_to deck_community_path(current_user)
    else
      flash[:alert] = "Deck community couldn´t be create, try again"
    end
  end

  def destroy
    @deck_community = DeckCommunity.find(params[:id])
    @deck_community.destroy
    redirect_to deck_community_path(current_user)
  end

  def market
    @my_deck_market = Deck.where(user_id: current_user, availability: "Commercial")
  end

  private

  def study_info(deckcomm)
    # returning nil if there is no deck community
    if deckcomm.nil?
      return nil
    end
    # selecting the deck which we want study infos
    deck = Deck.find(deckcomm.deck_id)

    # creating array of card's info which contains card_id, reps and grade
    cards_info = []
    deck.cards.each do |card|
      cards_info << Study.where(card_id: card)[0]
    end
    return cards_info
  end

  def score(cards_info)
    # selecting all cards that have been done at least once
    cards_info.reject! do |card_study|
      card_study.nil?
    end

    # summing total grades and dividing by the total number of repetitions to get score
    total_grade = 0
    total_reps = 0
    cards_info.each do |card_study|
      total_grade = total_grade + ( card_study.grade * card_study.repetition )
      total_reps = total_reps + card_study.repetition
    end

    total_reps.zero? ? score = 0 : score = (total_grade / total_reps)

    return score
  end

  def overall_info(deckcomm)
    # counting number of decks
    number_of_decks = deckcomm.count


    # counting number of cards
    number_of_cards = 0
    deckcomm.each do |deck|
      number_of_cards += deck.deck.cards.count
    end

    # counting number of sessions
    number_of_sessions = 0
    deckcomm.each do |deck|
      number_of_sessions += deck.user_progress.sessions unless deck.user_progress.nil?
    end

    # summing score and number of cards done of each deck community
    score = 0
    cards_done = 0
    decks_studied = 0
    deckcomm.each do |deck|
      unless deck.user_progress.nil?
        study_info = study_info(deck)
        score += score(study_info)
        cards_done += study_info.select {|study| study.repetition > 0}.count
        decks_studied += 1
      end
    end

    # calculating overall grade of cards studied
    if decks_studied == 0
      overall_grade = ""
    else
      overall_grade = (score / decks_studied).round(2) * 100
    end

    return {number_of_decks: number_of_decks, total_n_of_cards: number_of_cards, cards_done: cards_done, number_of_sessions: number_of_sessions, overall_grade: overall_grade }


  end


end
