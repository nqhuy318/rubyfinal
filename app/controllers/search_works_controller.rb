class SearchWorksController < ApplicationController
  def index
    @user = current_user
    if @user.nil?
      flash[:danger] = "Please login"
      redirect_to login_path
    else
      if @user[:role_id] == 1
        @works = Work.find_by_sql("with tbl_user AS(
select users.id AS user_id, categories.id AS category_id
  from users , categories,
 freelancer_categories AS fc where users.id = fc.user_id AND 
 categories.id = fc.category_id
), tbl_work AS(
select works.id AS work_id, categories.id AS category_id
  from works , categories,
 work_categories AS wc where works.id = wc.work_id AND 
 categories.id = wc.category_id
), tbl_wu AS(
select tw.work_id, tw.category_id, tu.user_id
 from tbl_work AS tw
 LEFT JOIN  tbl_user AS tu 
ON tw.category_id = tu.category_id 
), tbl_match AS(
select work_id, user_id, count() AS match_num from tbl_wu 
 where user_id IS NOT NULL
 GROUP BY work_id, user_id
 ), tbl_not_match AS(
select work_id, user_id, count() AS not_match_num from tbl_wu 
 where user_id IS NULL
 GROUP BY work_id, user_id
 )
 SELECT tm.work_id, 
 CASE WHEN tnm.not_match_num IS NULL 
 THEN 0 ELSE tnm.not_match_num END AS not_match_num, 
 tm.match_num , works.name, works.price, users.fullname
 from tbl_match AS tm LEFT JOIN tbl_not_match AS tnm
 ON tnm.work_id = tm.work_id
 JOIN works ON tm.work_id = works.id
 JOIN users ON works.user_id = users.id
 WHERE works.status = 0
 ORDER BY not_match_num ASC, match_num DESC
          ")
      else
        flash[:danger] = "You don't have permission"
        redirect_to @user
      end
    end
  end
end
