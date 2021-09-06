class DeckReviewsController < ApplicationController
  def new
    @review = DeckReview.new
  end

  def create
    @review = DeckReview.new(review_params)
    @deck = Deck.find(params[:id])
    @review.deck = @deck
    @review.user = current_user
    if @review.save
      redirect_to show_path
    else
      render new
    end
  end

  def destroy
  end

  private

  def review_params
    params.require(:deck_review).permit(:review_content, :rating)
  end

end
