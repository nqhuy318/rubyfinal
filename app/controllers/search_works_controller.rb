class SearchWorksController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :advance

  def index
    @user = current_user
    if @user.nil?
      flash[:danger] = "Please login"
      redirect_to login_path
    else
      if @user[:role_id] == 1
        @categories = Category.joins(:freelancer_categories).where(freelancer_categories:{user_id: @user[:id]})
        @works = Work.joins(:categories, :user).left_outer_joins(:joiners).where(status:[0, 4], categories:{id: @categories}).distinct
        @works = @works.sort do |a, b|
          case
          when check_not_match(@categories, a.categories) < check_not_match(@categories, b.categories)
            -1
          when check_not_match(@categories, a.categories) > check_not_match(@categories, b.categories)
            1
          else
            case
            when check_match(@categories, a.categories) < check_match(@categories, b.categories) 
              1
            when check_match(@categories, a.categories) > check_match(@categories, b.categories)
              -1
            else
              a.status <=> b.status
            end
          end
        end
        #        @work = sort_work(@works, @categories)
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
        if !params[:category_ids].nil?
          @categories = Category.joins(:freelancer_categories).where(freelancer_categories:{user_id: @user[:id]})
          @works = Work.joins(:categories, :user).where(status:[0, 4], categories:{id: params[:category_ids]}).distinct
          @works = @works.sort do |a, b|
            case
            when check_not_match(@categories, a.categories) < check_not_match(@categories, b.categories)
              -1
            when check_not_match(@categories, a.categories) > check_not_match(@categories, b.categories)
              1
            else
              case
              when check_match(@categories, a.categories) < check_match(@categories, b.categories) 
                1
              when check_match(@categories, a.categories) > check_match(@categories, b.categories)
                -1
              else
                a.status <=> b.status
              end
            end
          end
          #          @work = sort_work(@works, @categories)
        else
          @categories = Category.joins(:freelancer_categories).where(freelancer_categories:{user_id: @user[:id]})
          @works = Work.joins(:categories, :user).where(status:[0, 4], categories:{id: @categories}).distinct
          @works = @works.sort do |a, b|
            case
            when check_not_match(@categories, a.categories) < check_not_match(@categories, b.categories)
              -1
            when check_not_match(@categories, a.categories) > check_not_match(@categories, b.categories)
              1
            else
              case
              when check_match(@categories, a.categories) < check_match(@categories, b.categories) 
                1
              when check_match(@categories, a.categories) > check_match(@categories, b.categories)
                -1
              else
                a.status <=> b.status
              end
            end
          end
          #          @work = sort_work(@works, @categories)
        end
        render '_list_works', layout: false
      else
        flash[:danger] = "You don't have permission"
        redirect_to @user
      end
    end
  end
  
  def check_match(user_categories, work_categories)
    count = 0
    work_categories.each {
      |category| if check_exist(category, user_categories)
        count = count +1
      end
    }
    return count
  end
  
  def check_not_match(user_categories, work_categories)
    count = 0
    work_categories.each {|category|
      if !check_exist(category, user_categories)
        count = count +1
      end
    }
    return count
  end
  
  def check_exist(category, user_categories)
    check =  false
    user_categories.each { |user_category| 
      if user_category["id"] == category["id"]
        check = true
        break
      end
    }
    return check
  end
  
  #  def sort_work(work, categories)
  #    work = work.sort do |a, b|
  #      case
  #      when check_not_match(categories, a.categories) < check_not_match(categories, b.categories)
  #        -1
  #      when check_not_match(categories, a.categories) > check_not_match(categories, b.categories)
  #        1
  #      else
  #        case
  #        when check_match(categories, a.categories) < check_match(categories, b.categories) 
  #          1
  #        when check_match(categories, a.categories) > check_match(categories, b.categories)
  #          -1
  #        else
  #          a.status <=> b.status
  #        end
  #      end
  #    end
  #  end
end
