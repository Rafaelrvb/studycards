class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :decks # !!!! if user is destroyed we need some if cond to show user.name
  has_many :deck_communities, dependent: :destroy
  has_many :deck_reviews, dependent: :destroy

  has_many :studies, dependent: :destroy

  has_one_attached :profile_pic

  validates :name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
