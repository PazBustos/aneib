class AdministrationController < ApplicationController
	before_action :authenticate_user!
	before_action :validate_3
 
	
 	add_breadcrumb "Administración", :administration_index_path

	def index
		#No es necesario hacer llamados
	end	
	def noticias
		add_breadcrumb "Noticias", :administration_noticias_path
		@portals = Portal.where("section = ?", 1)
	end
	def somos
		add_breadcrumb "Quiénes somos", :administration_somos_path
		@portals = Portal.where("section = ?", 2)
	end
	def coneib
		add_breadcrumb "CONEIB", :administration_coneib_path
		@portals = Portal.where("section = ?", 3)
	end
	def estatuto
		add_breadcrumb "Estatuto", :administration_estatuto_path
		@portals = Portal.where("section = ?", 4)
	end
	def socio
		add_breadcrumb "HazteSocio", :administration_socio_path
		@portals = Portal.where("section = ?", 5)
	end
	def galerian
		add_breadcrumb "Galería", :administration_galeria_path
	end
	def cuentas
		add_breadcrumb "Cuentas claras", :administration_cuentas_path
		@finances = Finance.all
	end
	def organizacion
		add_breadcrumb "Organización congreso", :administration_organizacion_path
		@organizations = Organization.all
	end
	def recursos
		add_breadcrumb "Recursos", :administration_recursos_path
		@tipo1 = Resource.where(category: 1).order("created_at DESC")
		@tipo2 = Resource.where(category: 2).order("created_at DESC")
		@tipo3 = Resource.where(category: 3).order("created_at DESC")
		@tipo4 = Resource.where(category: 4).order("created_at DESC")
		@otros = Resource.where(category: 5).order("created_at DESC")
	end
	def topicos
		@topics = Topic.all
	end


private #acciones privadas del controlador

	def validate_3
      if current_user.category == 3
        redirect_to root_path, alert: "Su categoría no le permite ésta acción."
      end 
    end

end
