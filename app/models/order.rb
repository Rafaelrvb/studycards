class Order < ApplicationRecord
  belongs_to :user
  belongs_to :deck
  monetize :amount_cents
end
