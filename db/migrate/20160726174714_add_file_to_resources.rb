class AddFileToResources < ActiveRecord::Migration
	def change
		add_attachment :resources,:archive
	end
end
