class AddUserToDeck < ActiveRecord::Migration[6.0]
  def change
    add_column :decks, :availability, :string, default: "Public"
  end
end
