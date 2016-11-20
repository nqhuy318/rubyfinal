class SearchWorksController < ApplicationController
  def index
    @user = current_user
    if @user[:role_id] == 1
      
    end
  else
    flash[:danger] = "You don't have permission"
  end
end
