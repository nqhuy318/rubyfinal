class JoinersController < ApplicationController
  def create
    @joiner = Joiner.new(joiner_params)
    if @joiner.save
      flash[:success] = "Success!"
#      redirect_to @work
    else
      flash[:danger] = "Fail!"
#      render 'new'
    end
  end

  def edit
    @joiner = Joiner.find(params[:id])
  end

  def update
    @joiner = Joiner.find(params[:id])
    if @joiner.update_attributes(work_params)
      flash[:success] = "Success!"
      #      redirect_to @work
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
    params.require(:joiner).permit(:user_id, :work_id, :status)
  end
end
