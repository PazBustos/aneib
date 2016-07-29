class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, 
		:registerable,
		:recoverable, 
		:rememberable, 
		:trackable, 
		:validatable,
		:confirmable
		
	has_many :resources
	has_many :portals
	has_many :events
	has_many :finances
	has_many :articles
	has_many :topics
	has_many :comments
	has_attached_file :photo, styles: {mini:"30x30", medium: "500x200", thumb:"700x300"}, :default_url => ":style/missingPhoto.png"
	validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

	validates :name, presence: true, length:{maximum:50}
	validates :nickname, length:{maximum:14}
end
