class JoinersController < ApplicationController
  def create
    @joiner = Joiner.new(joiner_params)
    @joiner.status = 0
    check = Joiner.where(user_id: @joiner.user_id, work_id:@joiner.work_id)
    if check.empty?
      if @joiner.save
        flash[:success] = "Success!"
        redirect_to "/search_works"
      else
        flash[:danger] = "Fail!"
        render 'joiners/new'
      end
    else
      flash[:danger] = "You have joined in this work!"
      redirect_to "/search_works"
    end
  end

  def edit
    
  end

  def update
    @joiner = Joiner.find(params[:id])
    @joiner.status = 1
    if @joiner.update_attributes(joiner_params)
      flash[:success] = "Success!"
      redirect_to @joiner
    else
      render 'edit'
    end
  end

  def destroy
    Joiner.find(params[:id]).destroy
    #    redirect_to '/works'
  end
  
  private

  def joiner_params
    params.require(:joiner).permit(:user_id, :work_id)
  end
end
