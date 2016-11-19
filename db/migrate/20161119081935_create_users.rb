class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :fullname
      t.string :gender
      t.string :email
      t.string :contact
      t.string :info
      t.references :role, foreign_key: true

      t.timestamps
    end
  end
end
