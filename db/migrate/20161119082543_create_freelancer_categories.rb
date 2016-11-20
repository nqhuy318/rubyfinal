class CreateFreelancerCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :freelancer_categories do |t|
      t.float :skill_point
      t.float :experience_point
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
