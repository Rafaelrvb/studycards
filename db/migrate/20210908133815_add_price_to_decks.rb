class AddPriceToDecks < ActiveRecord::Migration[6.0]
  def change

    add_monetize :decks, :price, currency: { present: false }

  end
end
