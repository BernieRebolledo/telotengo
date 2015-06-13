class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :image
      t.string :gender
      t.boolean :verified
      t.string :provider_uid
      t.string :password

      t.timestamps null: false
    end
  end
end
