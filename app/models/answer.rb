class Answer < ActiveRecord::Base

 belongs_to :user
 belongs_to :question

 def show_user
 	user = User.where({:id => self.user_id}).first
 	user.name
 end

end