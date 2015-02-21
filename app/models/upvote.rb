class Upvote < ActiveRecord::Base
 validates_uniqueness_of :user_id, scope: :answer_id  #a user can only upvote an answer once. (for any upvote.answer_id, can only have one instance of any single upvote.user_id)

 belongs_to :user
 belongs_to :answer

end