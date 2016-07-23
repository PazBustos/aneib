class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :user, index: true, foreign_key: true
      t.string :tittle
      t.text :description
      t.string :picture
      t.date :date

      t.timestamps null: false
    end
  end
end
