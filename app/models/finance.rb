class Finance < ActiveRecord::Base
	belongs_to :user
	has_attached_file :archive
	validates_attachment_content_type :archive, 
	:content_type => [
		'application/pdf',
		'application/msword',
		'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
		'application/msexcel','application/vnd.ms-excel',
		'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
	]

	#Validaciones
	validates :title, presence: true, uniqueness: true, length: {maximum: 100}
	validates :description, presence: true, length: {maximum: 10000}
	validates :category, presence: true
	validates :date, presence: true


end
