class RemoveChosenAnswerFromAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :chosen_answer, :string
  end
end




