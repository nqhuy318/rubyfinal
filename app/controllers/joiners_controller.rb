class JoinersController < ApplicationController
  def create
    @joiner = Joiner.new(joiner_params)
    @joiner.status = 0
    check = Joiner.where(user_id: @joiner.user_id, work_id: @joiner.work_id)
    if check.empty?
      if @joiner.save
        flash[:success] = "Success!"
        @customer = User.joins(:works).where(works:{id: @joiner.work_id}).distinct.first
        NotifierMailer.send_join_to_customer(current_user, @customer)
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

  def update
    @joiner = Joiner.find(params[:id])
    @joiner.status = 1
    if @joiner.update_attributes(joiner_params)
      flash[:success] = "Success!"
      redirect_to @joiner.work
    else
      render 'edit'
    end
  end

  def destroy
    @joiner = Joiner.find(params[:id]).destroy
    redirect_to work_path(@joiner.work)
  end
  
  private

  def joiner_params
    params.require(:joiner).permit(:user_id, :work_id)
  end
end
