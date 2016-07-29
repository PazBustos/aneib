class TopicsController < ApplicationController
	before_action :set_topic, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	before_action :validate_status
	before_action :validate_1, only: [:edit, :update, :destroy, :create]
	before_action :validate_activity, only: [:show]
	add_breadcrumb "Foro", :topics_path

	def index
		@topics = Topic.where(status: 1)
	end

	def show
		@articles = @topic.articles.all
	end

	def new
		@topic = Topic.new
	end

	def edit
	end

	def create
		@topic = current_user.topics.new(topic_params)
		@topic.status = 1
		respond_to do |format|
			if @topic.save
				format.html { redirect_to @topic, notice: 'El área del foro ha sido creado existosamente' }
				format.json { render :show, status: :created, location: @topic }
			else
				format.html { render :new }
				format.json { render json: @topic.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @topic.update(topic_params)
				format.html { redirect_to administration_topicos_path, notice: 'El área del foro ha sido actualizado existosamente' }
				format.json { render :show, status: :ok, location: @topic }
			else
				format.html { render :edit }
				format.json { render json: @topic.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@topic.destroy
		respond_to do |format|
			format.html { redirect_to topics_url, notice: 'El área del foro ha sido eliminado existosamente' }
			format.json { head :no_content }
		end
	end

	private

		def set_topic
			@topic = Topic.find(params[:id])
		end
		
		def validate_activity
			if @topic.status == 2
				if current_user.category != 1
					redirect_to root_path, alert: "Este tema está inactivo o cerrado"
				end
			end
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
				redirect_to root_path, alert: "Solo el administrador puede realizar esta acción."
			end 
		end

		def topic_params
			params.require(:topic).permit(:user_id, :title, :description,:status)
		end
end
