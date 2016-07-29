class CreateResources < ActiveRecord::Migration
	def change
		create_table :resources do |t|
			t.references :user, index: true, foreign_key: true
			t.string :name
			t.text :description
			t.integer :category
			
			t.timestamps null: false
		end
	end
end
