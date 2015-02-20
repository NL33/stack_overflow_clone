class AnswersController < ApplicationController
  before_filter :authorize, only: [:new, :create, :edit, :update, :destroy]  #meaning must be logged in (per authorize method) to create, edit and update.
 
  def index 
    @answers = Answer.all
    @user = current_user
  end

  def new 
    @answer = current_user.answers.build  #this method (and the answers.build in create) makes it so that whenever a user creates a answer, it is automatically added to their profile (even if hit "add answer" while viewing another's profile)
    @question = Question.find(params[:question_id])
    question_creator_id = @question.user_id
    @current_user = current_user
    @question_creator = User.where({:id => question_creator_id}).first
    #another method would be to set this to current_user
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
        #flash[:notice] = "answer added."
        respond_to do |format|
          format.html { redirect_to root_path}
          format.js #refers to separate template--here, with create action in name (create.js.erb)
         end
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
  end

  def update  
    @question = Question.find(params[:question_id])
    question_creator_id = @question.user_id
    @current_user = current_user
    @question_creator = User.where({:id => question_creator_id}).first
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    respond_to do |format|
      format.html { redirect_to root_parth }
      format.js
    end
  end

 def destroy 
    @answer = Answer.find(params[:id])
    @answer.destroy
     flash[:notice] = "Answer Deleted"
    redirect_to root_path
 end

 private

    def answer_params
      params.require(:answer).permit(:text, :question_id, :chosen_answer)
    end

end