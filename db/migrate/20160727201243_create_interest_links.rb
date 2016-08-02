class CreateInterestLinks < ActiveRecord::Migration
	def change
		create_table :interest_links do |t|
			t.string :name
			t.string :url
			t.integer :social

			t.timestamps null: false
		end
	end
end
