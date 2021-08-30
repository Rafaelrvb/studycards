class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.references :deck, null: false, foreign_key: true
      t.text :front_page
      t.text :back_page

      t.timestamps
    end
  end
end
