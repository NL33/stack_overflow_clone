class Answer < ActiveRecord::Base

 default_scope { order('chosen_answer DESC, upvotes_count DESC')} #this sorts the answers displayed by: 1) Whether it is a chosen answer or not (chosen answer listed at top), then 2) upvotes_count (in descending order)

#Note alternative order methods include the following (in this case, would be in the questions show controller, where the answers form rendered): 
    #@answers = @question.answers.order("upvotes_count DESC")
    #@answers = @question.answers.order("chosen_answer DESC, upvotes_count DESC")
    #@answers = @question.answers.sort_by {|x| [x.upvotes_count]}
    #{ |a,b| a.upvotes_count <=> b.upvotes_count }. This changes array from a to b, sorted by upvotes_count}
    #@answers = @question.answers.order('upvotes_count')
    #extended method in the model:
      #create a hash (dictionary) with answers: upvote.count.  Then loop through and put answers and upvote.count into the hash. sort hash by upvote count. display hash.

 belongs_to :user
 belongs_to :question
 has_many :upvotes, :counter_cache => true #this means that Rails will auotmatically maintain a count of upvotes an answer gets (along with counter cache in upvote.)

 def show_user
 	user = User.where({:id => self.user_id}).first
 	user.name
 end

end
