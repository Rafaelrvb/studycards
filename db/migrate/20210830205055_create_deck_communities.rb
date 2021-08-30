class CreateDeckCommunities < ActiveRecord::Migration[6.0]
  def change
    create_table :deck_communities do |t|
      t.references :deck, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
