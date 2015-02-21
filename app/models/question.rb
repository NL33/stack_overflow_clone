class Question < ActiveRecord::Base

 belongs_to :user
 has_many :answers

 def order_by_upvotes #method to sort answers by upvotes:
  	answers = self.answers
    order_answers = {} #CREATE A (HASH) DICTIONARY WITH THE ANSWERS and UPVOTES: [Answer: Upvote.count, Answer: upvote.count]
    
    answers.each do |answer| #put answer and count into hash
        order_answers << answer
    	order_answers << answer.upvotes.count 
    end
    #sort hash by upvote count
    #display hash

  end

end


#From hackernews clone (in link.rb)
  #def self.order_by_rating_formula
   # links = Link.all
   # links_ordered_by_ratings = {}
   # links.each do |link|
    #  links_ordered_by_ratings[link] = link.rating_formula
    #end
   # updated_order = links_ordered_by_ratings.keys.sort {|a, b| links_ordered_by_ratings[b] <=> links_ordered_by_ratings[a]}
  #end