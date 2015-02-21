class Answer < ActiveRecord::Base

 default_scope { order('chosen_answer DESC')}


 belongs_to :user
 belongs_to :question
 has_many :upvotes

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

def order_by_upvotes #method to sort answers by upvotes:
    order_answers = {} #CREATE A (HASH) DICTIONARY WITH THE ANSWERS and UPVOTES: [Answer: Upvote.count, Answer: upvote.count]
    
    self.each do |answer| #put answer and count into hash
        order_answers << answer
    	order_answers << answer.upvotes.count 
    end
    #sort hash by upvote count
    #display hash

  end

end


#From hackernews clone (in link.rb)
  #def self.order_by_rating_formula
  #  links = Link.all
   # links_ordered_by_ratings = {}
   # links.each do |link|
    #  links_ordered_by_ratings[link] = link.rating_formula
    #end
   # updated_order = links_ordered_by_ratings.keys.sort {|a, b| links_ordered_by_ratings[b] <=> links_ordered_by_ratings[a]}
 # end
  
#end

