class SearchWorksController < ApplicationController
  def index
    @user = current_user
    if @user.nil?
      flash[:danger] = "Please login"
      redirect_to login_path
    else
      if @user[:role_id] == 1
        @categories = Category.joins(:freelancer_categories).where(freelancer_categories:{user_id: @user[:id]})
        @works = Work.joins(:categories).joins(:user).where(status:0, categories:{id: @categories}).distinct
        @works = @works.sort do |a, b|
          case
          when check_not_match(@categories, a.categories) < check_not_match(@categories, b.categories)
            -1
          when check_not_match(@categories, a.categories) > check_not_match(@categories, b.categories)
            1
          else
            case
            when check_match(@categories, a.categories) < check_match(@categories, b.categories) 
              -1
            when check_match(@categories, a.categories) > check_match(@categories, b.categories)
              1
            else
              a.categories.length <=> b.categories.length
            end
          end
        end
      else
        flash[:danger] = "You don't have permission"
        redirect_to @user
      end
    end
  end
  
  def advance
    @user = current_user
    if @user.nil?
      flash[:danger] = "Please login"
      redirect_to login_path
    else
      if @user[:role_id] == 1
        #        @categories = Category.joins(:freelancer_categories).where(freelancer_categories:{user_id: @user[:id]})
        if(!params[:category_ids].nil?)
          @categories = Category.joins(:freelancer_categories).where(freelancer_categories:{user_id: @user[:id]})
          @works = Work.joins(:categories).joins(:user).where(status:0, categories:{id: params[:category_ids]}).distinct
          @works = @works.sort do |a, b|
            case
            when check_not_match(@categories, a.categories) < check_not_match(@categories, b.categories)
              -1
            when check_not_match(@categories, a.categories) > check_not_match(@categories, b.categories)
              1
            else
              case
              when check_match(@categories, a.categories) < check_match(@categories, b.categories) 
                -1
              when check_match(@categories, a.categories) > check_match(@categories, b.categories)
                1
              else
                a.categories.length <=> b.categories.length
              end
            end
          end
        else
          @categories = Category.joins(:freelancer_categories).where(freelancer_categories:{user_id: @user[:id]})
          @works = Work.joins(:categories).joins(:user).where(status:0, categories:{id: @categories}).distinct
          @works = @works.sort do |a, b|
            case
            when check_not_match(@categories, a.categories) < check_not_match(@categories, b.categories)
              -1
            when check_not_match(@categories, a.categories) > check_not_match(@categories, b.categories)
              1
            else
              case
              when check_match(@categories, a.categories) < check_match(@categories, b.categories) 
                -1
              when check_match(@categories, a.categories) > check_match(@categories, b.categories)
                1
              else
                a.categories.length <=> b.categories.length
              end
            end
          end
        end
        
      else
        flash[:danger] = "You don't have permission"
        redirect_to @user
      end
    end
    render 'index'
  end
  def check_match(user_categories, *work_categories)
    count = 0
    work_categories.each {
      |category| if check_exist(category, user_categories)
        count = count +1
      end
      return count
    }
  end
  
  def check_not_match(user_categories, *work_categories)
    count = 0
    work_categories.each {
      |category| if !check_exist(category, user_categories)
        count = count +1
      end
      return count
    }
  end
  
  def check_exist(category, *user_categories)
    check =  false
    user_categories.each {
      |user_category| if user_category == category
        check = true
      end
    }
    return check
  end
end
