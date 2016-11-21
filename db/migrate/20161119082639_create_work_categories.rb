class CreateWorkCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :work_categories do |t|
      t.references :work, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
