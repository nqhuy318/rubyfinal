class CreateReviewFreelancers < ActiveRecord::Migration[5.0]
  def change
    create_table :review_freelancers do |t|
      t.string :content
      t.float :rank
      t.references :work, foreign_key: true
      t.references :joiner, foreign_key: true

      t.timestamps
    end
  end
end
