class AddPriceToDecks < ActiveRecord::Migration[6.0]
  def change
<<<<<<< HEAD
    add_monetize :decks, :price, currency: { present: false }
=======

    add_monetize :decks, :price, currency: { present: false }

>>>>>>> c653a8a1ad870d4ce8048fc9948d2c01e46a4440
  end
end
