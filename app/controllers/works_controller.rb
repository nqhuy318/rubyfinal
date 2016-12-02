class WorksController < ApplicationController

  def show
    @user = current_user
    if(@user[:role_id] == 2)
      @work = Work.joins(:categories).distinct.find(params[:id])
    elsif(@user[:role_id] == 1)
      @joiner = Joiner.new;
      @work = Work.joins(:categories).distinct.find(params[:id])
      render 'joiners/new'
    end
  end

  def new
    @work = Work.new
  end

  def index
    @user = current_user
    if @user.nil?
      flash[:danger] = "Please login"
      redirect_to login_path
    else
      if @user[:role_id] == 2
        @works = Work.where(user_id: @user.id).joins(:categories).distinct
      else
        flash[:warning] = "You don't have permission"
      end
    end
  end

  def create
    @user = current_user
    @work = Work.new(work_params)
    @work.category_ids = params[:category_ids]
    @work.user = @user
    if @user[:role_id] == 2&&@work.save
      @work.user = @user
    end
    if @work.save
      flash[:success] = "Project created"
      redirect_to @work
    else
      flash[:danger] = "Cannot create"
      render 'new'
    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if @work.update_attributes(work_params)
      flash[:success] = "Project updated!"
      redirect_to @work
    else
      render 'edit'
    end
  end

  def destroy
    Work.find(params[:id]).destroy
    redirect_to '/works'
  end

  private

  def work_params
    params.permit(:name, :description, :price)
  end
end
