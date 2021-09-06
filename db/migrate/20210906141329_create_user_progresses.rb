class CreateUserProgresses < ActiveRecord::Migration[6.0]
  def change
    create_table :user_progresses do |t|
      t.references :deck_community, null: false, foreign_key: true
      t.integer :sessions
      t.integer :cards_per_session

      t.timestamps
    end
  end
end
