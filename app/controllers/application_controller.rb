class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :set_topics
	before_action :set_interest_links
	add_breadcrumb "Inicio", :root_path
	
	private

		def set_topics
			@topics = Topic.where(status: 1)			
		end

		def set_interest_links
			@interest_links = InterestLink.all
		end
end
