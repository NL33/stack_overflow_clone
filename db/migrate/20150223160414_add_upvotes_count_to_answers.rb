class AddUpvotesCountToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :upvotes_count, :integer, :null => false, :default => 0
  end
end
