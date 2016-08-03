class PortalsController < ApplicationController
	before_action :set_portal, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:edit, :update, :destroy]
	before_action :validate_status,  only: [:edit, :update, :destroy]
	before_action :validate_2, only:[:newSomos,:newConeib,:newEstatuto,:newSocio]
	before_action :validate_3, except: [:index, :show, :somos, :coneib, :estatuto, :socio]
	before_action :validate_4, only:[:newSomos,:newConeib,:newEstatuto,:newSocio]
	before_action :validate_own, only: [:edit, :update, :destroy]


	def index
		@portals = Portal.paginate(:page => params[:page], :per_page => 5).where("section = ?", 1).order("created_at DESC")
	end

	def show
		add_breadcrumb "Administración", :administration_index_path
		if @portal.section == 1
			add_breadcrumb "Noticias", :administration_noticias_path
		elsif @portal.section == 2
			add_breadcrumb "Quiénes somos", :administration_somos_path
		elsif @portal.section == 3
			add_breadcrumb "CONEIB", :administration_coneib_path
		elsif @portal.section == 4
			add_breadcrumb "Estatuto", :administration_estatuto_path
		else
			add_breadcrumb "Hazte socio", :administration_socio_path
		end
		add_breadcrumb @portal.title
	end

	def new
		add_breadcrumb "Administración", :administration_index_path
		if @portal.section == 1
			add_breadcrumb "Noticias", :administration_noticias_path
		elsif @portal.section == 2
			add_breadcrumb "Quiénes somos", :administration_somos_path
		elsif @portal.section == 3
			add_breadcrumb "CONEIB", :administration_coneib_path
		elsif @portal.section == 4
			add_breadcrumb "Estatuto", :administration_estatuto_path
		else
			add_breadcrumb "Hazte socio", :administration_socio_path
		end
		add_breadcrumb "Nuevo"
		@portal = Portal.new
	end


	def edit
		add_breadcrumb "Administración", :administration_index_path
		if @portal.section == 1
			add_breadcrumb "Noticias", :administration_noticias_path
		elsif @portal.section == 2
			add_breadcrumb "Quiénes somos", :administration_somos_path
		elsif @portal.section == 3
			add_breadcrumb "CONEIB", :administration_coneib_path
		elsif @portal.section == 4
			add_breadcrumb "Estatuto", :administration_estatuto_path
		else
			add_breadcrumb "Hazte socio", :administration_socio_path
		end
		add_breadcrumb "Editando "+@portal.title
	end

	def create
		@portal = current_user.portals.new(portal_params)
		respond_to do |format|
			if @portal.save
				if @portal.section == 1
					format.html { redirect_to administration_noticias_path, notice: 'Se ha creado correctamente.' }
				elsif @portal.section == 2
					format.html { redirect_to administration_somos_path, notice: 'Se ha creado correctamente.' }
				elsif @portal.section == 3
					format.html { redirect_to administration_coneib_path, notice: 'Se ha creado correctamente.' }
				elsif @portal.section == 4
					format.html { redirect_to administration_estatuto_path, notice: 'Se ha creado correctamente.' }
				else
					format.html { redirect_to administration_socio_path, notice: 'Se ha creado correctamente.' }
				end
				format.json { render administration_index_path, status: :created, location: @portal }
			else
				format.html { render :new }
				format.json { render json: @portal.errors, status: :unprocessable_entity }
			end
		end
	end


	def update
		respond_to do |format|
			if @portal.update(portal_params)
				if @portal.section == 1
					format.html { redirect_to administration_noticias_path, notice: 'Se ha actualizado correctamente.' }
				elsif @portal.section == 2
					format.html { redirect_to administration_somos_path, notice: 'Se ha actualizado correctamente.' }
				elsif @portal.section == 3
					format.html { redirect_to administration_coneib_path, notice: 'Se ha actualizado correctamente.' }
				elsif @portal.section == 4
					format.html { redirect_to administration_estatuto_path, notice: 'Se ha actualizado correctamente.' }
				else
					format.html { redirect_to administration_socio_path, notice: 'Se ha actualizado correctamente.' }
				end
				format.json { render administration_index_path, status: :ok, location: @portal }
			else
				format.html { render :edit }
				format.json { render json: @portal.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@portal.destroy
		respond_to do |format|
			format.html { redirect_to administration_index_path, notice: 'Se ha eliminado correctamente.' }
			format.json { head :no_content }
		end
	end

	def newSomos
		add_breadcrumb "Administración", :administration_index_path
		add_breadcrumb "Quiénes somos", :administration_somos_path
		add_breadcrumb "Nueva publicación"
		@portal = Portal.new
	end

	def newConeib
		add_breadcrumb "Administración", :administration_index_path
		add_breadcrumb "CONEIB", :administration_coneib_path
		add_breadcrumb "Nueva publicación"
		@portal = Portal.new
	end

	def newNotice
		add_breadcrumb "Administración", :administration_index_path
		add_breadcrumb "Noticias", :administration_noticias_path
		add_breadcrumb "Nueva noticia"
		@portal = Portal.new
	end

	def newEstatuto
		add_breadcrumb "Administración", :administration_index_path
		add_breadcrumb "Estatuto", :administration_somos_path
		add_breadcrumb "Nuevo artículo"
		@portal = Portal.new
	end

	def newSocio
		add_breadcrumb "Administración", :administration_index_path
		add_breadcrumb "Hazte Socio", :administration_somos_path
		add_breadcrumb "Nuevo encabezado"
		@portal = Portal.new
	end

	def somos
		add_breadcrumb "Quiénes somos", :portals_somos_path
		@portals = Portal.where("section = ?", 2)
	end

	def coneib
		add_breadcrumb "CONEIB", :portals_coneib_path
		@portals = Portal.where("section = ?", 3)
	end

	def estatuto
		add_breadcrumb "Estatuto", :portals_estatuto_path
		@portals = Portal.order("title ASC").where("section = ?", 4)
	end

	def socio
		add_breadcrumb "Hazte socio", :portals_socio_path
		@portals = Portal.where("section = ?", 5)
	end

	private
		
		def set_portal
			@portal = Portal.find(params[:id])
		end

	 
		def portal_params
			params.require(:portal).permit(:user_id, :title, :body, :section)
		end

		def validate_status
			if current_user.status == 1
				redirect_to root_path, alert: "Su usuario no ha sido validado aún."
			end
			if current_user.status == 3
				redirect_to root_path, alert: "Su usuario ha sido bloqueado."
			end
		end
		def validate_2
			if current_user.category == 2
				redirect_to root_path, alert: "Los delegados no tienen permitidos realizar esta acción."
			end 
		end
		def validate_3
			if current_user.category == 3
				redirect_to root_path, alert: "Los socios no tienen permitidos realizar esta acción."
			end 
		end
		def validate_4
			if current_user.category == 4
				redirect_to root_path, alert: "Los media partner no tienen permitidos realizar esta acción."
			end 
		end
		def validate_own
			if current_user.category != 1 and current_user != @portal.user
				redirect_to root_path, alert: "Esta sección no le pertenece"
			end			
		end


end
	