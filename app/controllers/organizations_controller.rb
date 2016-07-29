	class OrganizationsController < ApplicationController
	before_action :set_organization, only: [:show, :edit, :update, :destroy]
	add_breadcrumb "Organización congreso", :organizations_path

	def index
	@organizations = Organization.all
	end

	def show
	end

	def new
		add_breadcrumb "Nuevo", :new_organization_path
		@organization = Organization.new
	end

	def edit
	end

	def create
		@organization = Organization.new(organization_params)
		respond_to do |format|
			if @organization.save
				format.html { redirect_to administration_organizacion_path, notice: 'La publicación ha sido creada exitosamente.' }
				format.json { render :show, status: :created, location: @organization }
			else
				format.html { render :new }
				format.json { render json: @organization.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @organization.update(organization_params)
				format.html { redirect_to administration_organizacion_path, notice: 'La publicación ha sido actualizada exitosamente.' }
				format.json { render :show, status: :ok, location: @organization }
			else
				format.html { render :edit }
				format.json { render json: @organization.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@organization.destroy
		respond_to do |format|
			format.html { redirect_to administration_organizacion_path, notice: 'La publicación ha sido eliminada exitosamente.' }
			format.json { head :no_content }
		end
	end

	private

		def set_organization
			@organization = Organization.find(params[:id])
		end

		def organization_params
			params.require(:organization).permit(:title, :description)
		end
end	
