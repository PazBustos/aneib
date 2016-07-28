class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :validate_1, only: [:edit,:update, :user_list]
	before_action :set_user, only: [:show, :edit, :update]

	def index
		add_breadcrumb "Perfil", :users_path
		@user = current_user
	end

	def user_list
		add_breadcrumb "Usuarios registrados"
		@users = User.all
	end
	
	def show
		add_breadcrumb "Perfil", :users_path
		add_breadcrumb "Perfil de "+@user.nickname
	end

	def edit
		add_breadcrumb "Perfil", :users_path
		add_breadcrumb "Editar perfil de "+@user.nickname
	end

	def update
		if @user.update(user_params)
			flash[:notice] = "El usuario ha sido actualizado correctamente"
			redirect_to @user
		else
			flash[:alert] = "Ha ocurrido un error en la actualización del usuario"
			render :edit
		end
	end
	
	private

	def validate_1
		if current_user.category != 1
			redirect_to root_path, alert: "Solo el administrador tiene este privilegio"
		end   
	end

	# Use callbacks to share common setup or constraints between actions.
	def set_user
		@user = User.find(params[:id])
	end
	
	def user_params
		accessible = [ :name, :email,:category,:status,:nickname, :photo ] # extend with your own params
     	accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      	params.require(:user).permit(accessible)
	end
end