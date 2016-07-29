class InterestLinksController < ApplicationController
	before_action :set_interest_link, only: [:show, :edit, :update, :destroy]

	def index
	@interest_links = InterestLink.all
	end

	def show
	end

	def new
		@interest_link = InterestLink.new
	end

	def edit
	end

	def create
		@interest_link = InterestLink.new(interest_link_params)
		respond_to do |format|
			if @interest_link.save
				format.html { redirect_to @interest_link, notice: 'El enlace de interes se ha creado exitosamente. '}
				format.json { render :show, status: :created, location: @interest_link }
			else
				format.html { render :new }
				format.json { render json: @interest_link.errors, status: :unprocessable_entity }
			end
		end
	end



	def update
		respond_to do |format|
			if @interest_link.update(interest_link_params)
				format.html { redirect_to @interest_link, notice: 'El enlace de interés se ha actualizado exitosamente.' }
				format.json { render :show, status: :ok, location: @interest_link }
			else
				format.html { render :edit }
				format.json { render json: @interest_link.errors, status: :unprocessable_entity }
			end
		end
	end



	def destroy
		@interest_link.destroy
		respond_to do |format|
			format.html { redirect_to interest_links_url, notice: 'El enlace de interés ha sido eliminado.' }
			format.json { head :no_content }
		end
	end

	private

		def set_interest_link
			@interest_link = InterestLink.find(params[:id])
		end


		def interest_link_params
			params.require(:interest_link).permit(
				:name, 
				:url, 
				:description)
		end
end
