class ContactsController < ApplicationController
	add_breadcrumb "Contacto", :contacts_path

	def index
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(contact_params)
		respond_to do |format|
			if @contact.save
				ContactMailer.contact_receiver(@contact).deliver
				ContactMailer.contact_sender(@contact).deliver
				format.html { redirect_to root_path, notice: 'Su mensaje ha sido enviado correctamente.' }
				format.json { render :show, status: :created, location: @contact }
			else
				format.html { render :index }
				format.json { render json: @contact.errors, status: :unprocessable_entity }
			end
		end
	end

	private

		def contact_params
			params.require(:contact).permit(
				:name, 
				:email, 
				:subject, 
				:body)
		end
end
