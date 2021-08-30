class CreateDeckReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :deck_reviews do |t|
      t.references :deck, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :review_content
      t.integer :rating

      t.timestamps
    end
  end
end
