class User < ActiveRecord::Base
  ROLES = %w[Student Teacher]
  has_many :courses
  has_many :pending_quizzes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def teacher?
    self.role == "Teacher"
  end
  
  def student?
    self.role == "Student"
  end
end
