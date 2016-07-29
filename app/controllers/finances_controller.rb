	class FinancesController < ApplicationController
	before_action :set_finance, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	before_action :validate_status
	before_action :validate_1, except: [:show, :index]
	before_action :validate_4
	add_breadcrumb "Cuentas claras", :finances_path

	def index
		@ingresos = Finance.where(category: 1).order("created_at DESC")
		@egresos = Finance.where(category: 2).order("created_at DESC")
		@balances = Finance.where(category: 3).order("created_at DESC")
	end

	def show
		add_breadcrumb "Mostrar", :finances_path
	end

	def new
		add_breadcrumb "Nuevo", :finances_path
		@finance = Finance.new
	end

	def edit
	end

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

	def destroy
		@finance.destroy
		respond_to do |format|
			format.html { redirect_to administration_cuentas_path, notice: 'La cuenta ha sido eliminada correctamente.' }
			format.json { head :no_content }
		end
	end

	private

		def set_finance
			@finance = Finance.find(params[:id])
		end

		def validate_status
			if current_user.status == 1
				redirect_to root_path, alert: "Su usuario no ha sido validado aún."
			end
			if current_user.status == 3
				redirect_to root_path, alert: "Su usuario ha sido bloqueado."
			end
		end
		
		def validate_1
			if current_user.category != 1
				redirect_to root_path, alert: "Su categoría no le permite ésta acción."
			end 
		end

		def validate_4
			if current_user.category == 4
				redirect_to root_path, alert: "Su categoría no le permite ésta acción."
			end 
		end

		def finance_params
			params.require(:finance).permit(
				:user_id, 
				:title, 
				:description,
				:archive,
				:date,
				:category)
		end
	
end
