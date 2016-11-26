class SearchWorksController < ApplicationController
  def index
    @user = current_user
    if @user.nil?
      flash[:danger] = "Please login"
      redirect_to login_path
    else
      if @user[:role_id] == 1
        #        @user[:id] = 1
        @categories = Category.joins(:freelancer_categories).where(freelancer_categories:{user_id: @user[:id]})
        @works = Work.find_by_sql(["with tbl_wu AS(
select DISTINCT wc.work_id
 from work_categories AS wc
 LEFT JOIN freelancer_categories  AS fc
ON wc.category_id = fc.category_id where fc.user_id = "+@user[:id].to_s+"
), tbl_match AS(
select DISTINCT work_id, count() as match_num from work_categories as wc 
where wc.category_id in (select category_id from freelancer_categories where user_id = "+@user[:id].to_s+")  and wc.work_id in (select * from tbl_wu)
group by wc.work_id
),  tbl_not_match AS (
select DISTINCT work_id, count() as not_match_num from work_categories as wc 
where wc.category_id not in (select category_id from freelancer_categories where user_id = "+@user[:id].to_s+")  and wc.work_id in (select * from tbl_wu)
group by wc.work_id
)
select m.work_id, m.match_num, works.name, users.fullname, users.id, works.price,
 CASE WHEN nm.not_match_num IS NULL THEN 0 ELSE nm.not_match_num END AS not_match_num from 
tbl_match as m NATURAL LEFT JOIN tbl_not_match as nm 
JOIN works ON m.work_id = works.id JOIN users ON works.user_id = users.id
order by not_match_num ASC, match_num DESC
            "])
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
        @categories = Category.joins(:freelancer_categories).where(freelancer_categories:{user_id: @user[:id]})
        if(!params[:category_ids].nil?)
          @works = Work.find_by_sql(["with tbl_wu AS(
select DISTINCT wc.work_id
 from work_categories AS wc
 LEFT JOIN freelancer_categories  AS fc
ON wc.category_id = fc.category_id where fc.user_id = "+@user[:id].to_s+"
), tbl_match AS(
select DISTINCT work_id, count() as match_num from work_categories as wc 
where wc.category_id in (#{params[:category_ids].join(', ')})  and wc.work_id in (select * from tbl_wu)
group by wc.work_id
),  tbl_not_match AS (
select DISTINCT work_id, count() as not_match_num from work_categories as wc 
where wc.category_id not in (#{params[:category_ids].join(', ')})  and wc.work_id in (select * from tbl_wu)
group by wc.work_id
)
select m.work_id, m.match_num, works.name, users.fullname, users.id, works.price,
 CASE WHEN nm.not_match_num IS NULL THEN 0 ELSE nm.not_match_num END AS not_match_num from 
tbl_match as m NATURAL LEFT JOIN tbl_not_match as nm 
JOIN works ON m.work_id = works.id JOIN users ON works.user_id = users.id
order by not_match_num ASC, match_num DESC
              "])
        else
          @works = Work.find_by_sql(["with tbl_wu AS(
select DISTINCT wc.work_id
 from work_categories AS wc
 LEFT JOIN freelancer_categories  AS fc
ON wc.category_id = fc.category_id where fc.user_id = "+@user[:id].to_s+"
), tbl_match AS(
select DISTINCT work_id, count() as match_num from work_categories as wc 
where wc.category_id in (select category_id from freelancer_categories where user_id = "+@user[:id].to_s+")  and wc.work_id in (select * from tbl_wu)
group by wc.work_id
),  tbl_not_match AS (
select DISTINCT work_id, count() as not_match_num from work_categories as wc 
where wc.category_id not in (select category_id from freelancer_categories where user_id = "+@user[:id].to_s+")  and wc.work_id in (select * from tbl_wu)
group by wc.work_id
)
select m.work_id, m.match_num, works.name, users.fullname, users.id, works.price,
 CASE WHEN nm.not_match_num IS NULL THEN 0 ELSE nm.not_match_num END AS not_match_num from 
tbl_match as m NATURAL LEFT JOIN tbl_not_match as nm 
JOIN works ON m.work_id = works.id JOIN users ON works.user_id = users.id
order by not_match_num ASC, match_num DESC
              "])
        end
        
      else
        flash[:danger] = "You don't have permission"
        redirect_to @user
      end
    end
    render 'index'
  end
end
