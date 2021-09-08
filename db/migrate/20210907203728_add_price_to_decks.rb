class AddPriceToDecks < ActiveRecord::Migration[6.0]
  def change
    add_column :decks, :price, :float, default: 0
  end
end
