class CreateFinances < ActiveRecord::Migration
  def change
    create_table :finances do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.integer :classification

      t.timestamps null: false
    end
  end
end
