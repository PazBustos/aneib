class CreateFinances < ActiveRecord::Migration
	def change
		create_table :finances do |t|
			t.references :user, index: true, foreign_key: true
			t.string :title
			t.text :description
			t.integer :category
			t.datetime :date

			t.timestamps null: false
		end
	end
end
