class CreateJoiners < ActiveRecord::Migration[5.0]
  def change
    create_table :joiners do |t|
      t.references :user, foreign_key: true
      t.references :work, foreign_key: true
      t.date :joined_date
	  t.integer:status

      t.timestamps
    end
  end
end
