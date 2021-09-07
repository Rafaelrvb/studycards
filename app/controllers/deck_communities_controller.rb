class DeckCommunitiesController < ApplicationController
  def index
  end

  def show
    @deck_community = DeckCommunity.where(user: current_user)
    unless @deck_community.empty?
      unless study_info(@deck_community[params[:var].to_i])[0].nil?
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
    deck_community = DeckCommunity.where(user: current_user)
    @my_deck_market = deck_community.select do |deckcomm|
      deckcomm.deck.user_id == current_user.id && deckcomm.deck.availability == 'Commercial'
    end


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

    return total_grade / total_reps
  end


end
