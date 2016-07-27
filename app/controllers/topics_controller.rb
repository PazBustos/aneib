class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :validate_1, only: [:edit, :update, :destroy, :create]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.where(status: 1)
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @articles = @topic.articles.all
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = current_user.topics.new(topic_params)
    @topic.status = 1
    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'El tema del foro ha sido creado existosamente' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to administration_topicos_path, notice: 'El tema del foro ha sido actualizado existosamente' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'El tema del foro ha sido eliminado existosamente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end
    def validate_1
      if current_user.category != 1
        redirect_to root_path, alert: "Solo el administrador puede realizar esta acción."
      end 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:user_id, :title, :description,:status)
    end
end
