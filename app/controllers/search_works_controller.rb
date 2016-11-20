class SearchWorksController < ApplicationController
  def index
    @user = current_user
    if @user[:role_id] == 1
      @works = Work.joins(:work_categories).joins(:categories)
      .joins(:user).where(status: 0, :work_categories=>{category_id:1})
    else
      flash[:danger] = "You don't have permission"
      redirect_to @user
    end
  end
end
