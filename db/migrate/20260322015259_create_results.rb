class CreateResults < ActiveRecord::Migration[7.2]
  def change
    create_table :results do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.integer :total_score, null: false, default: 0
      t.integer :correct_count, null: false, default: 0
      t.integer :total_time_seconds, null: false, default: 0

      t.timestamps
    end
  end
end
