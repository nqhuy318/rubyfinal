class WorksController < ApplicationController

  def show
    @user = current_user
    unless @user.nil?
      if(@user[:role_id] == 2)
        #        @joiner = Joiner.new;
        @work = Work.joins(:user).left_outer_joins(:categories, :joiners).distinct.where(id: params[:id]).first
#        @work.status+=1
      elsif(@user[:role_id] == 1)
        @joiner = Joiner.new;
        @work = Work.joins(:user).left_outer_joins(:joiners, :categories,).distinct.where(id: params[:id]).first
        render 'joiners/new'
      end
    else
      redirect_to login_path
    end
  end

  def new
    unless current_user.nil?
      if current_user[:role_id] == 2
        @work = Work.new
        @work.categories.build
      else
        flash[:danger] = "You don't have permission"
        redirect_to current_user
      end
    else
      flash[:danger] = "Please login"
      redirect_to login_path
    end
  end

  def index
    @user = current_user
    if @user.nil?
      flash[:danger] = "Please login"
      redirect_to login_path
    else
      if @user[:role_id] == 2
        @works = Work.where(user_id: @user.id).left_outer_joins(:categories).distinct.order("status")
      else
        flash[:warning] = "You don't have permission"
      end
    end
  end

  def create
    @user = current_user
    @work = Work.new(work_params)
    @work.status = 0
    @work.category_ids = params[:category_ids]
    @work.user = @user
    @work.status = 0
    if @user[:role_id] == 2 && @work.save
      @work.user = @user
    end
    if @work.save
      flash[:success] = "Work created"
      redirect_to @work
    else
      flash[:danger] = "Cannot create"
      render 'new'
    end
  end

  def edit
    unless current_user.nil?
      if current_user[:role_id] == 2
        @work = Work.find(params[:id])
      else
        flash[:danger] = "You don't have permission"
        redirect_to current_user
      end
    else
      flash[:danger] = "Please login"
      redirect_to login_path
    end
  end

  def update
    @work = Work.find(params[:id])
    #    unless params[:status].nil?
    #      @work.status = work_params[:status]
    #    end
    #    @test = Work.new(work_params)
    #    @work.status = @test.status
    if @work.update_attributes(work_params)
      flash[:success] = "Work updated!"
      redirect_to @work
    else
      render 'edit'
    end
  end

  def destroy
    Work.find(params[:id]).destroy
    redirect_to works_path
  end
  
  private

  def work_params
    params.permit(:name, :description, :price, :status)
  end
end
