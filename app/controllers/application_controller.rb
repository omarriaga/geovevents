class ApplicationController < ActionController::Base
  protect_from_forgery

  def render_errors(errors, status = 200)
    (@errors = errors); render 'api/errors/fail_with_errors', :formats => :json, :status => status
  end
  
end
