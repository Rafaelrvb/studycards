class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy
  has_many :deck_communities, dependent: :destroy
  has_many :deck_reviews, dependent: :destroy

  validates :title, presence: true
  validates :title, uniqueness: { scope: [:user_id] }

end
