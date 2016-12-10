class TakeTestController < ApplicationController
  def index
    if logged_in?
      if current_user[:role_id] == 1
        @check = User.joins(:categories).where(id: current_user, categories:{id: params[:id]})
        if !@check.empty? 
          unless is_loaded?
            @tests = Question.where(category_id: params[:id]).joins(:answers).order("RANDOM()").limit(3).distinct
            unless @tests.empty?
              load_test @tests
              @count_down = 15
            end
          else
            #            arr = []
            #            print current_test.to_yaml
            #            current_test.each{|q|
            #              arr.push(q['id'])
            #            }
            #            @tests = Question.where(id: arr).joins(:answers).distinct
            #            @count_down = get_time
            destroy_test
            flash[:danger] = "Cancel test!"
            redirect_to current_user
          end
        else 
          flash[:warning] = "You don't have permission"
          redirect_to current_user
        end
      else
        flash[:warning] = "You don't have permission"
        redirect_to current_user
      end
    else
      flash[:danger] = "Please login"
      redirect_to login_path
    end
  end
  
  def create
    @fc = FreelancerCategory.where(category_id: params[:id], user_id:current_user).first
    unless @fc.nil?
      test = current_test
      count = 0.0
      test.each_with_index do |test, index|
        if !params[index.to_s].nil?
          if check_answer(params[index.to_s])
            count = count + 1.0
          end
        end
      end
      @fc.skill_point = count*5.0
      @fc.save
      redirect_to @fc.user
    else
      redirect_to current_user
    end
    destroy_test
  end
end
