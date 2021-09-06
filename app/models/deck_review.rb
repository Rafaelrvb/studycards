class DeckReview < ApplicationRecord
  belongs_to :deck
  belongs_to :user

  validates :rating, inclusion: {in: (1..5)}

end
