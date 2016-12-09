class FreelancerCategoriesController < ApplicationController
  def index
    @user = current_user
    if @user.nil?
      flash[:danger] = "Please login"
      redirect_to login_path
    else
      if @user[:role_id] == 1
        @works = FreelancerCategory.where(user: @user.id)
      else
        flash[:warning] = "You don't have permission"
      end
    end
  end
end
