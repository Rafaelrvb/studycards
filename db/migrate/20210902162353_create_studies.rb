class CreateStudies < ActiveRecord::Migration[6.0]
  def change
    create_table :studies do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :card_id
      t.integer :repetition, default: 1
      t.float :grade

      t.timestamps
    end
  end
end
