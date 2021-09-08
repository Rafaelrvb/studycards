class AddSkuToDecks < ActiveRecord::Migration[6.0]
  def change
    add_column :decks, :sku, :string
  end
end
