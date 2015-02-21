class AnswersController < ApplicationController
  before_filter :authorize, only: [:new, :create, :edit, :update, :destroy]  #meaning must be logged in (per authorize method) to create, edit and update.
 
  def index 
    @answers = Answer.all
    @user = current_user
  end

  def new 
    @answer = current_user.answers.build  #this method (and the answers.build in create) makes it so that whenever a user creates a answer, it is automatically added to their profile 
    @question = Question.find(params[:question_id])
    question_creator_id = @question.user_id
    @current_user = current_user #probably not necessary
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
       @question = Question.find(params[:question_id])
    @user = current_user
    @upvote = Upvote.new
     if @answer.save
        respond_to do |format|
          format.html { redirect_to root_path}
          format.js #refers to separate answer template--here, with create action in name (views/answers/create.js.erb)
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
    @other_answers = @answer.find_other_answers
    @other_answers.each do |other_answer| 
       other_answer.update({:chosen_answer => false}) #updates all other answers to not be chosen answer when @answer is chosen
    end
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