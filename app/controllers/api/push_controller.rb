class Api::PushController < ApplicationController

	before_filter :verify_application
	def create

		
	end

private
	def verify_application
		@application = Application.find_by_application_token(params[:application_token])
		if @application.nil?
			
		end

	end
end