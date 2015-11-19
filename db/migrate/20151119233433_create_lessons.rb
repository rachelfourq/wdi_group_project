class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :user, index: true, foreign_key: true
      t.string :url

      t.timestamps null: false
    end
  end
end
