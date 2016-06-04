class QuizAnswersController < ApplicationController
  before_action :set_pending_quiz
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  
  def index
  end
  
  def new
    @answer = @pending_quiz.quiz_answers.build
  end
  
  def create
    @answer = @pending_quiz.quiz_answers.build(answer_params)
    
    if @answer.save
      redirect_to @pending_quiz
    else
      render nothing: true #TO DO
    end
  end

  def show
  end

  def edit
  end
  
  def update
  end
  
  def destroy
    @answer.destroy
    redirect_to @pending_quiz
  end
  
  private
  
  def set_pending_quiz
    @pending_quiz = PendingQuiz.find(params[:pending_quiz_id])
  end
  
  def set_answer
    @answer = @pending_quiz.quiz_answers.find(params[:id])
  end
  
  
  def answer_params
    params.require(:quiz_answer).permit(:answer)
  end
end