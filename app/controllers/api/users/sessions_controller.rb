# -*- encoding : utf-8 -*-
class Apis::Users::SessionsController < ApplicationController

  before_filter :authorizing!, :only => [:destroy, :update]
  def create
    respond_to do |format|
      format.any{
        render_errors([I18n.t(:invalid_format)])
      }
      format.json{
        @session = Session.new(params[:session])
        if @session.save
          render 'api/users/signin'
        else
          render_errors(@session.errors.full_messages)
        end
      }
    end
  end

  def update
    respond_to do |format|
      format.any{
        render_errors([I18n.t(:invalid_format)])
      }
      format.json{
        Delayed::Job.destroy(@token.job_id)
        if @token.destroy
          auth_token = Digest::SHA1.hexdigest([Time.now, rand].join)
          time = Time.now
          @token = @current_user.tokens.new({:auth_token => auth_token, :expire_time => time + 72.hour})
          if @token.save
            job = @token.delay(queue: "tokens", priority: 1, run_at: 72.hour.from_now).destroy
            @token.update_attribute(:job_id, job.id)
            render 'api/users/renew'
          else
            render_errors(@token.errors.full_messages)
          end
        else
          render_errors(@token.errors.full_messages)
        end
      }
    end
  end

  def destroy
    respond_to do |format|
      format.any{
        render_errors([I18n.t(:invalid_format)])
      }
      format.json{
        token = Token.find_by_auth_token(params[:auth_token])
        if !token.nil?
          Delayed::Job.destroy(token.job_id)
          token.destroy
          render 'api/users/confirmation'
        else
          render_errors(["No se puede autenticar"])            
        end
      }
    end
  end

end
