class QuestionsController < ApplicationController
  before_filter :authorize, only: [:new, :create, :edit, :update, :destroy]  #meaning must be logged in (per authorize method) to create, edit and update.
 
  def index 
    @questions = Question.all
    @user = current_user
  end

  def new 
    @question = current_user.questions.build  #this method (and the questions.build in create) makes it so that whenever a user creates a question, it is automatically added to their profile 
    @user = current_user #another method would be to set this to current_user
    #as opposed to questions.build method, if wanted to make it so could only create question from within your profile (eg, if viewing the show page of another user, could not create a question yourself from that page), could use this that raises an error:
      #if @user != current_user  
      # flash[:notice] = "you are not authorized to do post a question for that account."
       #redirect_to root_path 
    #end
  end

  def create
    @question = current_user.questions.build(question_params)
    @user = current_user
     if @question.save
        flash[:notice] = "question added."
        redirect_to root_path 
      else
        render 'new' 
      end
  end

  def show
    @question = Question.find(params[:id]) 
    user_id = @question.user_id
    @user = User.where({:id => user_id }).first 
    @upvote = Upvote.new
  end

  def edit  
    if User.find(params[:user_id]) != current_user
      flash[:notice] = "You are not permitted to edit this question"
      redirect_to root_path
    else
      @user = current_user
      @question = Question.find(params[:id])
    end
  end

  def update 
    @question = Question.find(params[:id])
    @answers = question.answers
    

    @question.update(question_params)
     flash[:notice] = "Question Updated"
    redirect_to root_path
  end

 def destroy 
    @question = Question.find(params[:id])
    @question.destroy
     flash[:notice] = "Question Deleted"
    redirect_to root_path
 end

 private

    def question_params
      params.require(:question).permit(:title, :text)
    end

end