# -*- encoding : utf-8 -*-
class Apis::Users::UsersApiController < ApplicationController
  
  skip_authorization_check
  
  before_filter :valid_password, :only => [:update]
  before_filter :authorizing!, :only => [:show, :update, :reputation]
  
  def create 
    respond_to do |format|
      format.any {
        render_errors([I18n.t(:invalid_format)])
      }
      format.json{
        application = Application.find_by_application_token(params[:application_token]) 
        if !application.nil?
          if !params[:user].nil?
            @user = application.userApis.new(params[:user])
            if @user.save
              RegisterMailer.delay(queue: 'mailing').register_confirmation(@user.convert_to_open_struct)
              #RegisterMailer.register_confirmation(@user.convert_to_open_struct).deliver
              job = @user.delay(queue: 'register', priority: 1, run_at: 1.hour.from_now).destroy
              
              @user.update_attribute(:job_id, job.id)
              render "api/users/register"
            else
              render_errors(@user.errors.full_messages)
            end
          else
            render_errors(['No se ha enviado la información necesaria'])
          end
        else
          render_errors(['No se puede autenticar'])
        end
      }
    end
  end
  
  def update
    respond_to do  |format|
      format.any{
        render_errors([I18n.t(:invalid_format)])
      }
      format.json{
        token = Token.find_by_auth_token(params[:auth_token])
        if !token.nil?
          if !(user = token.tokenizer).nil?
            if user.update_attributes(params[:user])
              render 'api/users/confirmation'
            else
              render_errors(user.errors.full_messages)
            end
          end
        else
          render_errors(['No se puede autenticar'])  
        end
      }  
    end
  end
  
  def show
    respond_to do |format|
      format.any{
        render_errors([I18n.t(:invalid_format)])
      }
      format.json{
        token = Token.find_by_auth_token(params[:auth_token])
        if !token.nil?
          @user = token.tokenizer
          render "api/users/show"
        else
          render_errors(["sesión invalida"])
        end
      }
      
    end
  end
  
  def reputation
    respond_to do |format|
      format.any{
        render_errors(I18n.t(:invalid_format))
      }
      format.json{
        @ranking = Ranking.new({:user => @current_user, :pusher_key => params[:pusher_key]})
        if @ranking.save
          render "api/users/reputation"
        else
          render_errors(@ranking.errors.full_messages)
        end
      }
    end
  end
    

  
end
