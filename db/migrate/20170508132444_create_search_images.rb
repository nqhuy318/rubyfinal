class CreateSearchImages < ActiveRecord::Migration[5.0]
  def change
    create_table :search_images do |t|

      t.timestamps
    end
  end
end
