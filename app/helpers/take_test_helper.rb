module TakeTestHelper
  def load_test(questions)
    session[:questions] = questions
  end
  
  def current_test
    @current_test = session[:questions]
  end
  
  def is_loaded?
    unless session[:questions].nil?
      return true
    else
      return false
    end 
  end
  
  def destroy_test
    session.delete(:questions)
    @current_test = nil
  end
  
  #  def get_time
  #    @count_down = session[:time]
  #  end
  
  #  def set_count_down_time(time)
  #    session[:time] = time
  #    #  
  #    #  def current_question(index)
  #    #    @current_test ||= Question.find_by(id: session[:questions][index][:id])
  #  end
  
  #  def get_true_answer(question)
  #    @true_answer = Answer.joins(:question).where(tf:1, questions:{id: question})
  #    logger.debug @true_answer.to_yaml
  #  end
  
    def check_answer(answer)
      @true_answer = Answer.where(tf:1, id: answer)
      if @true_answer.empty?
        return false
      else
        return true
      end
    end
end
