class ResourcesController < ApplicationController
	before_action :set_resource, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	before_action :validate_status
	before_action :validate_3, except: [:show, :index]
	before_action :validate_4
	
	def index
		add_breadcrumb "Recursos", :resources_path
		@actas = Resource.where(category: 1).order("created_at DESC")
		@planillas = Resource.where(category: 2).order("created_at DESC")
		@extras = Resource.where(category: 3).order("created_at DESC")
	end

	def show
		add_breadcrumb "Recursos", :resources_path
		add_breadcrumb @resource.name
	end

	def new
		add_breadcrumb "Administración", :administration_index_path
		add_breadcrumb "Recursos", :administration_recursos_path
		add_breadcrumb "Nuevo"
		@resource = Resource.new
	end

	def edit
		add_breadcrumb "Administración", :administration_index_path
		add_breadcrumb "Recursos", :administration_recursos_path
		add_breadcrumb "Editando "+@resource.name
	end

	def create
		@resource = current_user.resources.new(resource_params)

		respond_to do |format|
			if @resource.save
				format.html { redirect_to administration_recursos_path, notice: 'Recurso creado con éxito.' }
				format.json { render :show, status: :created, location: @resource }
			else
				format.html { render :new }
				format.json { render json: @resource.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @resource.update(resource_params)
				format.html { redirect_to administration_recursos_path, notice: 'Recurso actualizado con éxito.' }
				format.json { render :show, status: :ok, location: @resource }
			else
				format.html { render :edit }
				format.json { render json: @resource.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@resource.destroy
		respond_to do |format|
			format.html { redirect_to administration_recursos_path, notice: 'El recurso se ha eliminado.' }
			format.json { head :no_content }
		end
	end

	private
		
		def set_resource
			@resource = Resource.find(params[:id])
		end

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

		def validate_4
			if current_user.category == 4
				redirect_to root_path, alert: "Su categoría no le permite ésta acción."
			end 
		end

		def resource_params
			params.require(:resource).permit(
				:name, 
				:description, 
				:category, 
				:archive, 
				:user_id)
		end

end
