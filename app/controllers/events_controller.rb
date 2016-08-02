class EventsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :listado]
	before_action :validate_status, except: [:index,:show, :listado]
	before_action :validate_3, except: [:index, :show, :listado]
	before_action :set_event, only: [:show, :edit, :update, :destroy]
	add_breadcrumb "Eventos", :events_path

	def index
		@events = Event.where(status: 1)
	end

	def show
		add_breadcrumb @event.title
		@event_comment = EventComment.new
		if @event.end_time < Time.now && @event.status == 1
			@event.update(status: 2)
			flash[:success] = "Este evento ya fue realizado"
		end
	end

	def new
		add_breadcrumb "Nuevo evento"
		@event = Event.new
	end

	def edit
		add_breadcrumb "Editando evento"
	end

	def listado
		add_breadcrumb "Todos los eventos"
		@vigentes = Event.where(status: 1)
		@realizados = Event.where(status: 2)
	end

	def create
		@event = current_user.events.new(event_params)
		respond_to do |format|
			if @event.save
				err=0
				a=0
				b=0
				c=0
				if @event.end_time ==  @event.start_time
					@event.update(end_time: @event.end_time+1.hours)
					err = 1
					a = 1
				end
				if @event.end_time < @event.start_time
					@aux = @event.end_time
					@event.update(end_time: @event.start_time)
					@event.update(start_time: @aux)
					err = 1;
					b = 1
				end
				if @event.start_time < @event.created_at - 30.minutes 
					@diferencia = @event.end_time - @event.start_time
					@event.update(start_time: Time.now) 
					@event.update(end_time: Time.now+@diferencia)
					err = 1;
					c = 1
				end
				if err == 1
					flash[:alert] = "La fecha ingresada no es válida, se ha puesto una fecha estimativa válida automáticamente."
					if a == 1
						flash[:alert] = "Las fechas no pueden ser iguales."
					end
					if b == 1
						flash[:alert] = "La fecha de término no puede ser anterior a la de inicio."
					end
					if c == 1
						flash[:alert] = "Las fechas no pueden ser menor a la fecha actual"
					end
				end
				
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
