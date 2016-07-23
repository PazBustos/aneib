class CreatePortals < ActiveRecord::Migration
  def change
    create_table :portals do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :body
      t.integer :priority
      t.integer :section

      t.timestamps null: false
    end
  end
end
