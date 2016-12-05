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
    end 
    return false
  end
  
  def destroy_test
    session.delete(:questions)
    @current_test = nil
  end
  
  def get_time
    @count_down = session[:time]
  end
  
  def set_count_down_time(time)
    session[:time] = time
  end
end
