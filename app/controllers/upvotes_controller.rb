class UpvotesController < ApplicationController
  before_filter :authorize, only: [:new, :create, :update]  #meaning must be logged in (per authorize method) to create, edit and update.
 

  def new 
   @upvote = current_user.upvotes.build  #this method (and the upvotes.build in create) makes it so that whenever a user creates a upvote, it is automatically added to their profile  
  end

  def create
    @upvote = current_user.upvotes.build(upvote_params)
    @answer = @upvote.answer
    @upvote.save
    respond_to do |format|
         format.html { redirect_to :back}
         format.js #refers to separate upvotes template--here, with create action in name (views/upvotes/create.js.erb)
    end
  end


  def edit  
    if User.find(params[:user_id]) != current_user
      flash[:notice] = "You are not permitted to edit this upvote"
      redirect_to root_path
    else
      @user = current_user
      @upvote = Upvote.find(params[:id])
    end
  end

  def update 
    @upvote = Upvote.find(params[:id])
    @answers = upvote.answers

    @upvote.update(upvote_params)
     flash[:notice] = "Upvote Updated"
    redirect_to root_path
  end


 private

    def upvote_params
      params.require(:upvote).permit(:user_id, :answer_id)
    end

end