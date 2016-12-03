class TakeTestController < ApplicationController
  def index
    if logged_in?
      if current_user[:role_id] == 1
        @check = User.joins(:categories).where(id: current_user, categories:{id: params[:id] })
        if !@check.empty? 
          @tests = Question.where(category_id: params[:id]).joins(:answers).order("RANDOM()").limit(3).distinct
          load_test @tests
          #          @fc = FreelancerCategory.where(category_id: params[:id], user_id:current_user)
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
          #          logger.debug test['id']
          #          count = test[:id]
          if check_answer(params[index.to_s])
            count = count + 1.0
          end
        end
      end
      @fc.skill_point = count*5.0
      @fc.save
    else
      redirect_to current_user
    end
  end
end
