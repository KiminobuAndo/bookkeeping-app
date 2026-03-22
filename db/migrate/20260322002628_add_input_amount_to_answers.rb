class AddInputAmountToAnswers < ActiveRecord::Migration[7.2]
  def change
    add_column :answers, :input_amount, :integer
  end
end
