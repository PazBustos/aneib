class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_article
  before_action :authenticate_user!
  before_action :validate_status
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all.order('created_at DESC')
  end

  # GET /comments/1
  # GET /comments/1.json
  def show

  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.article = @article

    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_article_path(@topic,@article), notice: 'El comentario ha sido agregado' }
        format.json { render :show, status: :created, location: topic_article_path(@topic,@article) }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.article, notice: 'El comentario ha sido actualizado' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to topic_article_path(@topic,@article), notice: 'El comentario ha sido eliminado exitosamente' }
      format.json { head :no_content }
    end
  end

  private

    def set_article
      @article = Article.find(params[:article_id])
      @topic = @article.topic
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end
    def validate_status
      if current_user.status != 2
        redirect_to root_path, alert: "Su usuario no ha sido validado aún."
      end 
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :article_id, :body)
    end
end
