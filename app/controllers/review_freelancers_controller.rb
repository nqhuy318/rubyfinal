class ReviewFreelancersController < ApplicationController

  def new
  	@review_freelancer = ReviewFreelancer.new
  	@review_freelancer.joiner_id = params[:id]
  	@review_freelancer.work_id = 37
	joiner = Joiner.find_by(id: @review_freelancer.joiner_id)
  	@work = Work.where(id: joiner.work_id).joins(:work_categories).first
  	freelancer_category = FreelancerCategory.where(user_id: joiner.user_id, category_id: @work.categories)
  	unless current_user[:id] == @work.user_id
  		flash[:danger] = "You don't have permission"
  		redirect_to current_user
  	end
  end
  def create
  	@review_freelancer = ReviewFreelancer.new(review_freelancer_params)
	joiner = Joiner.find_by(id: @review_freelancer.joiner_id)
  	work = Work.where(id: joiner.work_id).joins(:work_categories).first
  	freelancer_category = FreelancerCategory.where(user_id: joiner.user_id, category_id: work.categories)
  	@review_freelancer.work_id = work.id
  	unless current_user[:id] == work.user_id
  		flash[:danger] = "You don't have permission"
  		redirect_to current_user
  	else
  		if @review_freelancer.save
  			freelancer_category.each do |fc|
  				unless fc.experience_point.nil?
					fc.experience_point += @review_freelancer.rank
				else
					fc.experience_point = @review_freelancer.rank
				end
				fc.save
	  		end
	  		flash[:success] = "Review successful"
	  		redirect_to work_path(work)
	  	else
	  		flash[:warning] = "Cannot review"
	  		render 'new'
	 	end
 	end
  end
  def index
  end
	private

	def review_freelancer_params
		params.require(:review_freelancer).permit(:content, :joiner_id, :rank)
	end
end
