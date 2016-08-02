class EventCommentsController < ApplicationController
	before_action :set_event_comment, only: [:show, :edit, :update, :destroy]
	before_action :set_event
	before_action :authenticate_user!
	def create
		@event_comment = current_user.event_comments.new(event_comment_params)
		@event_comment.event = @event
		
		respond_to do |format|
			if @event_comment.save
				format.html { redirect_to @event, notice: 'Tu comentario ha sido realizado correctamente.' }
				format.json { render :show, status: :created, location: @event_comment }
			else
				format.html { redirect_to @event, alert: 'El comentario no pudo ser realizado (Entre 2 y 400 caracteres)' }
				format.json { render json: @event_comment.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@event_comment.destroy
		respond_to do |format|
			format.html { redirect_to @event, notice: 'Se ha eliminado el comentario correctamente.' }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_event
			@event = Event.find(params[:event_id])
		end

		def set_event_comment
			@event_comment = EventComment.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def event_comment_params
			params.require(:event_comment).permit(:body, :user_id, :event_id)
		end
end
