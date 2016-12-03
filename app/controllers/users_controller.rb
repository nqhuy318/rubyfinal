class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    unless params[:category_ids].nil?
      @user.category_ids = params[:category_ids]
    end
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Freelancer Website!"
      redirect_to @user
    else
      flash[:danger] = "Cannot create account!"
      render 'new'
    end
  end

  private
  def user_params
    params.permit(:fullname, :username, :email, :password, :password_confirmation, :role_id)
  end
end