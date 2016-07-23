class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.text :description
      t.integer :category
      t.date :date

      t.timestamps null: false
    end
  end
end
