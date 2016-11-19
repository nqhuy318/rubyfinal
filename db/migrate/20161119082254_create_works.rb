class CreateWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :works do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :description
      t.string :price
      t.date :created_date
      t.date :deadline
      t.integer:status

      t.timestamps
    end
  end
end
