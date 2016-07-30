class AdministrationController < ApplicationController
	before_action :authenticate_user!
	before_action :validate_status
	before_action :validate_3
 
 	add_breadcrumb "Administración", :administration_index_path

	def index
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
		add_breadcrumb "Hazte socio", :administration_socio_path
		@portals = Portal.where("section = ?", 5)
	end

	def cuentas
		add_breadcrumb "Cuentas claras", :administration_cuentas_path
		@ingresos = Finance.where(category: 1).order("created_at DESC")
		@egresos = Finance.where(category: 2).order("created_at DESC")
		@balances = Finance.where(category: 3).order("created_at DESC")
	end
	def organizacion
		add_breadcrumb "Organización congreso", :administration_organizacion_path
		@organizations = Organization.all
	end
	def recursos
		add_breadcrumb "Recursos", :administration_recursos_path
		@actas = Resource.where(category: 1).order("created_at DESC")
		@planillas = Resource.where(category: 2).order("created_at DESC")
		@extras = Resource.where(category: 3).order("created_at DESC")

	end
	def topicos
		add_breadcrumb "Foro", :administration_topicos_path
		@topics = Topic.all
	end


	private #acciones privadas del controlador

		def validate_status
			if current_user.status == 1
				redirect_to root_path, alert: "Su usuario no ha sido validado aún."
			end
			if current_user.status == 3
				redirect_to root_path, alert: "Su usuario ha sido bloqueado."
			end
		end
		
		def validate_3
			if current_user.category == 3
				redirect_to root_path, alert: "Su categoría no le permite ésta acción."
			end 
		end

end
