class Organization < ActiveRecord::Base

	belongs_to :user
	#has_many :organization_comments

	#Validaciones
	validates :title, presence: true, uniqueness: true, length: {maximum: 100} #no pueden haber dos titulos iguales
	validates :description, presence: true, length: {minimum: 20, maximum: 10000} 
end
