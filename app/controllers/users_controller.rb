class UsersController < ApplicationController

  def show
    if logged_in?
      @user = User.left_outer_joins(:joiners, :categories, :freelancer_categories).where(id: params[:id]).first
    else
      redirect_to login_path
    end
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

  def edit
    if logged_in?
      @user = User.joins(:role).where('id' =>params[:id]).first
    else
      redirect_to login_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @work.update_attributes(work_params)
      flash[:success] = "Profile updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  def user_params
    params.permit(:fullname, :username, :email, :password, :password_confirmation, :role_id, :contact, :info, :gender)
  end
end