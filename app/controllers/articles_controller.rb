class ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :edit, :update, :destroy]
	before_action :set_topic
	before_action :authenticate_user!
	before_action :validate_status
	before_action :validate_activity

	def index
		@articles = Article.all
	end

	def show
		@comment = Comment.new
	end

	def new
		@article = Article.new
	end


	def edit
	end

	def create
		@article = current_user.articles.new(article_params)
		@article.topic_id = @topic.id

		respond_to do |format|
			if @article.save
				format.html { redirect_to @topic, notice: 'El post ha sido creado exitosamente' }
				format.json { render :show, status: :created, location: @topic }
			else
				format.html { render :new }
				format.json { render json: @article.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
			respond_to do |format|
			if @article.update(article_params)
				format.html { redirect_to @topic, notice: 'El post ha sido actualizado exitosamente' }
				format.json { render :show, status: :ok, location: @topic }
			else
				format.html { render :edit }
				format.json { render json: @article.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@article.destroy
		respond_to do |format|
			format.html { redirect_to articles_url, notice: 'El post ha sido eliminado exitosamente' }
			format.json { head :no_content }
		end
	end

	private

		def set_article
			@article = Article.find(params[:id])
		end
		
		def set_topic
			@topic = Topic.find(params[:topic_id])
		end
		
		def validate_status
			if current_user.status == 1
				redirect_to root_path, alert: "Su usuario no ha sido validado aún."
			end
			if current_user.status == 3
				redirect_to root_path, alert: "Su usuario ha sido bloqueado."
			end
		end
				
		def validate_activity
			if @topic.status == 2
				if current_user.category != 1
					redirect_to root_path, alert: "Este tema está inactivo o cerrado"
				end
			end
		end

		def article_params
			params.require(:article).permit(
				:user_id, 
				:topic_id, 
				:title, 
				:description)
		end
end
