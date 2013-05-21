class Api::PushController < ApplicationController

	before_filter :verify_application
	def create
		respond_to do |format|
			format.any{
				render_errors ["invalid format just JSON"]
			}
			format.json{}
		end
	end

private
	def verify_application
		@application = Application.find_by_application_token(params[:application_token])
		if @application.nil?
			render_errors(["invalid application"])
		end
	end
end