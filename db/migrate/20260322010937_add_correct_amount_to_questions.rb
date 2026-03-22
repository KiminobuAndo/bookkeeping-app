class AddCorrectAmountToQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :questions, :correct_amount, :integer
  end
end
