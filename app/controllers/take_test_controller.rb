class TakeTestController < ApplicationController
  def index
    @tests = Question.where(category_id: params[:id]).joins(:answers).order("RANDOM()").limit(3).distinct
  end
end
