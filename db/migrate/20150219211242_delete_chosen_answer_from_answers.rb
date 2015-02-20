class DeleteChosenAnswerFromAnswers < ActiveRecord::Migration
   def change
    remove_column :answers, :chosen_answer, :boolean
  end
end