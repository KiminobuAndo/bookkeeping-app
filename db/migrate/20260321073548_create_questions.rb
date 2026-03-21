class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.references :course, null: false, foreign_key: true
      t.text :prompt, null: false
      t.string :correct_side, null: false

      t.timestamps
    end
  end
end
