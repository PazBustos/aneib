class ContactMailer < ApplicationMailer
	default from: 'aneibchile@gmail.com'
	def contact_sender(contact)
		@contact = contact
		mail(to: @contact.email, subject: @contact.subject)
	end
	def contact_receiver(contact)
		@contact = contact
		mail(to: 'aneibchile@gmail.com', subject: @contact.subject)
	end
end
