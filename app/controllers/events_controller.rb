class EventsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :validate_status, except: [:index,:show]
	before_action :validate_3, except: [:index, :show]
	before_action :set_event, only: [:show, :edit, :update, :destroy]
	add_breadcrumb "Eventos", :events_path

	def index
	@eventnts = Event.all
	end

	def show
		add_breadcrumb @event.title
	end

	def new
		add_breadcrumb "Nuevo evento"
		@event = Event.new
	end

	def edit
		add_breadcrumb "Editando evento"
	end

	def create
		@event = current_user.events.new(event_params)
		@event.status = 1

		respond_to do |format|
			if @event.save
				format.html { redirect_to @event, notice: 'El evento ha sido creado correctamente.' }
				format.json { render :show, status: :created, location: @event }
			else
				format.html { render :new }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @event.update(event_params)
				format.html { redirect_to @event, notice: 'El evento ha sido actualizado correctamente.' }
				format.json { render :show, status: :ok, location: @event }
			else
				format.html { render :edit }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@event.destroy
		respond_to do |format|
			format.html { redirect_to events_url, notice: 'El evento ha sido eliminado correctamente.' }
			format.json { head :no_content }
		end
	end

	private

		def set_event
			@event = Event.find(params[:id])
		end

		def validate_status
			if current_user.status == 1
				redirect_to root_path, alert: "Su usuario no ha sido validado aún."
			end
			if current_user.status == 3
				redirect_to root_path, alert: "Su usuario ha sido bloqueado."
			end
		end
		
		def validate_3
			if current_user.category == 3
				redirect_to root_path, alert: "Su categoría no le permite ésta acción."
			end 
		end

		def event_params
			params.require(:event).permit(
				:user_id, 
				:title, 
				:address, 
				:status, 
				:description, 
				:start_time,
				:end_time)
		end

	end
