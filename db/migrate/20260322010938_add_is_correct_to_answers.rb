class AddIsCorrectToAnswers < ActiveRecord::Migration[7.2]
  def change
    add_column :answers, :is_correct, :boolean
  end
end
