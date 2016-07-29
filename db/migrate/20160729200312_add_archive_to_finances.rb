class AddArchiveToFinances < ActiveRecord::Migration
	def change
		add_attachment :finances,:archive
	end
end
