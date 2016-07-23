class FinancesController < ApplicationController
  before_action :set_finance, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Cuentas claras", :finances_path

  # GET /finances
  # GET /finances.json
  def index
    @finances = Finance.all
  end

  # GET /finances/1
  # GET /finances/1.json
  def show
      add_breadcrumb "Mostrar", :finances_path
  end

  # GET /finances/new
  def new
    add_breadcrumb "Nuevo", :finances_path
    @finance = Finance.new
  end

  # GET /finances/1/edit
  def edit
  end

  # POST /finances
  # POST /finances.json
  def create
    @finance = current_user.finances.new(finance_params)
    
    respond_to do |format|
      if @finance.save
        format.html { redirect_to administration_cuentas_path, notice: 'La cuenta ha sido agregada correctamente.' }
        format.json { render :show, status: :created, location: @finance }
      else
        format.html { render :new }
        format.json { render json: @finance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /finances/1
  # PATCH/PUT /finances/1.json
  def update
    respond_to do |format|
      if @finance.update(finance_params)
        format.html { redirect_to administration_cuentas_path, notice: 'La cuenta ha sido actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @finance }
      else
        format.html { render :edit }
        format.json { render json: @finance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /finances/1
  # DELETE /finances/1.json
  def destroy
    @finance.destroy
    respond_to do |format|
      format.html { redirect_to administration_cuentas_path, notice: 'La cuenta ha sido eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_finance
      @finance = Finance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def finance_params
      params.require(:finance).permit(:user_id, :title, :description, :classification)
    end
end
