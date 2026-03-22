class CreateResultDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :result_details do |t|
      t.references :result, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.string :answer_side, null: false
      t.boolean :is_correct, null: false, default: false
      t.integer :elapsed_seconds
      t.integer :score, null: false, default: 0

      t.timestamps
    end
  end
end
