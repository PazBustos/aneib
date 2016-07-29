class ContactMailer < ApplicationMailer
	default from: 'paz.bustos.m@gmail.com'
	def contact_receiver(contact)
		@contact = contact
		mail(to: 'paz.bustos.m@gmail.com', subject: @contact.subject)
	end
	def contact_sender(contact)
		@contact = contact
		mail(to: @contact.email, subject: @contact.subject)
	end

end
