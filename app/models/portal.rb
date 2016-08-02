class Portal < ActiveRecord::Base
	belongs_to :user

	#Validaciones
	validates :title, presence: true, uniqueness: true, length: {maximum: 100}
	validates :body, presence: true, length: {minimum: 20, maximum: 10000}
	validates :section, presence: true
end
