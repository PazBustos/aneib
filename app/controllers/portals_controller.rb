class PortalsController < ApplicationController
  before_action :set_portal, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :validate_status, except: [:show, :index]
  before_action :validate_3, except: [:show, :index]

  # GET /portals
  # GET /portals.json
  def index
    @portals = Portal.where("section = ?", 1)
  end

  # GET /portals/1
  # GET /portals/1.json
  def show
      add_breadcrumb "Mostrar", :root_path
  end

  # GET /portals/new
  def new
    @portal = Portal.new
  end

  # GET /portals/1/edit
  def edit
  end

  # POST /portals
  # POST /portals.json
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

  # PATCH/PUT /portals/1
  # PATCH/PUT /portals/1.json
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

  # DELETE /portals/1
  # DELETE /portals/1.json
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
  
  def admin
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
    add_breadcrumb "Estatuto", :portals_socio_path
    @portals = Portal.where("section = ?", 5)
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portal
      @portal = Portal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portal_params
      params.require(:portal).permit(:user_id, :title, :body, :section)
    end
    def validate_status
      if current_user.status != 2
        redirect_to root_path, alert: "Su usuario no ha sido validado aún."
      end 
    end
    def validate_3
      if current_user.category == 3
        redirect_to root_path, alert: "Su categoría no le permite ésta acción."
      end 
    end


end
