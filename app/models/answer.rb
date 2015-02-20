class Answer < ActiveRecord::Base

 default_scope { order('chosen_answer DESC')}

 belongs_to :user
 belongs_to :question

 def show_user
 	user = User.where({:id => self.user_id}).first
 	user.name
 end

  def find_other_answers #produces array of question.answers other than self (for use in taking action on these other answers)
 	answer = self
 	question = Question.where({:id => self.question_id}).first
 	array = question.answers
 	updated_array = array.reject{|element| element == answer}
    updated_array
  end

end