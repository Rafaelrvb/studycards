class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy
  has_many :deck_communities, dependent: :destroy
  has_many :deck_reviews, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3 }
  validates :description, length: { minimum: 6 }
  validates :title, uniqueness: { scope: [:user_id] }
  validates :availability, inclusion: {in: ["Public","Private", "Commercial"]}

  include PgSearch::Model
  pg_search_scope :search_by_title_description,
    against: [:title, :description],
    using: {
      tsearch: { prefix: true }
    }

end
