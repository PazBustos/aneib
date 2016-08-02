class Article < ActiveRecord::Base
	belongs_to :user
	belongs_to :topic

	has_many :comments, dependent: :destroy 

	#Validates
	validates :title, presence: true, length:{maximum:100}
end
