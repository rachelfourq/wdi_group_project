class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :provider_id
      t.string :provider_hash
      t.string :email
      t.string :name
      t.string :cloud_id

      t.timestamps null: false
    end
  end
end
