module TakeTestHelper
  def load_test(questions)
    session[:questions] = questions
  end
  
  def current_test
    @current_test = session[:questions]
  end
  #  
  #  def current_question(index)
  #    @current_test ||= Question.find_by(id: session[:questions][index][:id])
  #  end
  
  def get_true_answer(question)
    @true_answer = Answer.joins(:question).where(tf:1, questions:{id: question})
    logger.debug @true_answer.to_yaml
  end
  
  def check_answer(answer)
    @true_answer = Answer.where(tf:1, id: answer)
    if @true_answer.empty?
      return false
    else
      return true
    end
  end
end
