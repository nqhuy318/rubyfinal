class SearchWorksController < ApplicationController
  def index
    @user = current_user
    if @user.nil?
      flash[:danger] = "Please login"
      redirect_to login_path
    else
      if @user[:role_id] == 1
        @works = Work.joins(:work_categories).joins(:categories)
        .joins(:user).where(status: 0, :work_categories=>{category_id:1}).distinct
      else
        flash[:danger] = "You don't have permission"
        redirect_to @user
      end
    end
  end
end
