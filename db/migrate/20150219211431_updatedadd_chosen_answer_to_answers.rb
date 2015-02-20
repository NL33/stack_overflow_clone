class UpdatedaddChosenAnswerToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :chosen_answer, :boolean, default: false, null: false 
  end
end