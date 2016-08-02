class Event < ActiveRecord::Base
	belongs_to :user
	has_many :event_comments, dependent: :destroy 

	#Validaciones
	validates :title, presence: true, uniqueness: true, length: {maximum: 100} #no pueden haber dos titulos iguales
	validates :description, presence: true, length: {minimum: 20, maximum: 10000} #validar maximos y minimos de caracteres
	validates :address, presence: true #no puede haber carácteres en blanco
	validates :status, presence: true

end
