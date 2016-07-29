class Finance < ActiveRecord::Base
	belongs_to :user
	has_attached_file :archive
	validates_attachment_content_type :archive, 
	:content_type => ['application/pdf','application/msword','application/vnd.openxmlformats-officedocument.wordprocessingml.document','application/msexcel','application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','application/mspowerpoint','application/vnd.ms-powerpoint','application/vnd.openxmlformats-officedocument.presentationml.presentation']
	
end
