class CreateArticles < ActiveRecord::Migration
	def change
		create_table :articles do |t|
			t.references :user, index: true, foreign_key: true
			t.references :topic, index: true, foreign_key: true, on_delete: :cascade
			t.string :title
			t.text :description
			t.integer :status

			t.timestamps null: false
		end
	end
end
