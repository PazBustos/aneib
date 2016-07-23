class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
    
    add_breadcrumb "Inicio", :root_path
    add_breadcrumb "Recursos", :resources_path

  # GET /resources
  # GET /resources.json
  def index
    @tipo1 = Resource.where(category: 1).order("created_at DESC")
    @tipo2 = Resource.where(category: 2).order("created_at DESC")
    @tipo3 = Resource.where(category: 3).order("created_at DESC")
    @tipo4 = Resource.where(category: 4).order("created_at DESC")
    @otros = Resource.where(category: 5).order("created_at DESC")
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    add_breadcrumb "Mostrar"
  end

  # GET /resources/new
  def new
    @resource = Resource.new
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = Resource.new(resource_params)

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

  # PATCH/PUT /resources/1
  # PATCH/PUT /resources/1.json
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

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to administration_recursos_path, notice: 'El recurso se ha eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Resource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(:name, :description, :category, :date,:archive)
    end
end
