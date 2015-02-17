class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :text
      t.string :question_id
      t.string :user_id
      t.string :chosen_answer #original posting user selects
      t.integer :upvote

      t.timestamps
    end
  end
end