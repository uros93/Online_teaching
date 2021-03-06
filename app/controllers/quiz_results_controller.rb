class QuizResultsController < ApplicationController
  load_and_authorize_resource :except => [:create]
  def new
    @pending_quiz ||= PendingQuiz.find(params[:pending_quiz_id])
    
    @quiz_result = @pending_quiz.build_quiz_result
    @pending_quiz.quiz_answers.each do |qa|
      @quiz_result.answer_comments.build
    end
  end
  
  def create
    @pending_quiz = PendingQuiz.find(params[:quiz_result][:pending_quiz_id])
   @quiz_result = @pending_quiz.build_quiz_result(quiz_result_params)
   @quiz_result.user = current_user
   if @quiz_result.save
     @pending_quiz.graded = true
     @pending_quiz.save
     redirect_to my_quizzes_path
   else
     render "new"
   end
    
  end

  def show
    @quiz_result = QuizResult.find(params[:id])
    @questions = @quiz_result.pending_quiz.quiz.questions
    @answers = @quiz_result.pending_quiz.quiz_answers
  end

  def index
    @quiz_results = QuizResults.all
  end
  
  private 
  
  def quiz_result_params
    params.require(:quiz_result).permit(:grade,:pending_quiz_id, answer_comments_attributes: [:description, :id, :quiz_answer_id])
  end
end
