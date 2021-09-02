class Card < ApplicationRecord
  belongs_to :deck
  has_one_attached :photo
end
