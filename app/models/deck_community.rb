class DeckCommunity < ApplicationRecord
  belongs_to :deck
  belongs_to :user
  has_one :user_progress, dependent: :destroy

end
