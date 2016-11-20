class WorksController < ApplicationController

  def show
    @work = Work.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @user = current_user
    @work = Work.new(work_params)
    @work.user = @user
    #    @work = @user.build(params[:work])
    if @work.save
      flash[:success] = "Project created"
      #      redirect_to @work
    else
      flash[:danger] = "Cannot create"
      render 'new'
    end
  end

  def index
    @works = Work.all
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

  private

  def work_params
    params.require(:work).permit(:name, :description, :price)
    
  end
end
