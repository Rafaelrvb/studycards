class AddPriceToDecks < ActiveRecord::Migration[6.0]
  def change
<<<<<<< HEAD:db/migrate/20210908133815_add_price_to_decks.rb
    add_monetize :decks, :price, currency: { present: false }
=======
    add_column :decks, :price, :float, default: 0
>>>>>>> b707c785dedae2255d4a405016ae397f46834587:db/migrate/20210907203728_add_price_to_decks.rb
  end
end
