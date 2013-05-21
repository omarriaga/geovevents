# -*- encoding : utf-8 -*-
class Apis::Users::ConfirmationsController < ApplicationController
  def create
    respond_to do |format|
      format.any{
        render_errors([I18n.t(:invalid_format)])
      }
      format.json{
        @confirmation = Confirmation.new(params[:confirmation])
        if !@confirmation.nil?
          if @confirmation.save
            render "api/users/confirmation"
          else
            render_errors(@confirmation.errors.full_messages)
          end
        else
          render_errors(["Confirmación invalida"])
        end
      }
    end
  end

  def forward
    respond_to do |format|
      format.any {
        render_errors([I18n.t(:invalid_format)])
      }
      format.json {
        @user = UserApi.find_by_email(params[:email])
        if !@user.nil?
          if !@user.confirmed
            @user.change_confirmation
            if @user.save(validate: false)
              RegisterMailer.delay(:queue => 'mailing').register_confirmation(@user.convert_to_open_struct)
              #RegisterMailer.register_confirmation(@user.convert_to_open_struct).deliver
              render "api/users/register"
            end
          else
            render_errors(['Esta cuenta ya esta confirmada'])
          end
        else
          render_errors(['Este usuario no se encuentra registrado'])
        end
      }
    end
  end

end
