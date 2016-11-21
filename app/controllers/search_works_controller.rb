class SearchWorksController < ApplicationController
  def index
    @user = current_user
    if @user[:role_id] == 1
<<<<<<< HEAD
      
    end
  else
    flash[:danger] = "You don't have permission"
=======
      @works = Work.joins(:work_categories).joins(:categories)
      .joins(:user).where(status: 0, :work_categories=>{category_id:1}).distinct
    else
      flash[:danger] = "You don't have permission"
      redirect_to @user
    end
>>>>>>> 03daf97c98930b6552003010aeea46a1483c0f21
  end
end
