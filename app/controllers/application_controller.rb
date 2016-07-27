class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_action :set_topics
	before_action :set_interest_links
	private
		def set_topics
			@topics = Topic.all  		
		end

		def set_interest_links
			@interest_links = InterestLink.all
		end
end
