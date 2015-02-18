class AnswersController < ApplicationController
  before_filter :authorize, only: [:new, :create, :edit, :update, :destroy]  #meaning must be logged in (per authorize method) to create, edit and update.
 
  def index 
    @answers = Answer.all
    @user = current_user
  end

  def new 
    @answer = current_user.answers.build  #this method (and the answers.build in create) makes it so that whenever a user creates a answer, it is automatically added to their profile (even if hit "add answer" while viewing another's profile)
    @user = current_user #another method would be to set this to current_user
    #as opposed to answers.build method, if wanted to make it so could only create answer from within your profile (eg, if viewing the show page of another user, could not create a answer yourself from that page), could use this that raises an error:
      #if @user != current_user  
      # flash[:notice] = "you are not authorized to do post a answer for that account."
       #redirect_to root_path 
    #end
  end

  def create
    @answer = current_user.answers.build(answer_params)
    @user = current_user
     if @answer.save
        flash[:notice] = "answer added."
        redirect_to root_path 
      else
        render 'new' 
      end
  end

  def show
    @answer = Answer.find(params[:id]) 
    user_id = @answer.user_id
    @user = User.where({:id => user_id }).first 
    @answer = Answer.new
  end

  def edit  
    if User.find(params[:user_id]) != current_user
      flash[:notice] = "You are not permitted to edit this answer"
      redirect_to root_path
    else
      @user = current_user
      @answer = Answer.find(params[:id])
    end
  end

  def update 
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
     flash[:notice] = "Answer Updated"
    redirect_to root_path
  end

 def destroy 
    @answer = Answer.find(params[:id])
    @answer.destroy
     flash[:notice] = "Answer Deleted"
    redirect_to root_path
 end

 private

    def answer_params
      params.require(:answer).permit(:text)
    end

end