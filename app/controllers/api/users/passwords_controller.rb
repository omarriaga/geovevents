# -*- encoding : utf-8 -*-
class Apis::Users::PasswordsController < ApplicationController
  
  def recovery
    respond_to do |format|
      format.any{
        render_errors([I18n.t(:invalid_format)])
      }
      format.json{
        @user = UserApi.find_by_email(params[:email])
        if !@user.nil?
          if @user.confirmed
            @user.change_confirmation
            if @user.save(validate: false)
               RegisterMailer.delay(:queue => 'recovery').recovery_password(@user.convert_to_open_struct)
               #RegisterMailer.recovery_password(@user.convert_to_open_struct).deliver
               render "api/users/register"
            else
              render_errors(['En estos momentos no se pudo efectuar el envio. Inténtelo de nuevo más tarde'])
            end
          else
            render_errors(['El usuario no esta confirmado'])
          end
        else
            render_errors(["El correo electrónico ingresado, no es valido"])
        end
      }
    end
  end
  def change 
    respond_to do |format|
      format.any{
        render_errors([I18n.t(:invalid_format)])
      }
      format.json{
        @checker = Checker.new(params[:checker])
        if !@checker.nil?
          if @checker.save
            render "api/users/confirmation"
          else
            render_errors(@checker.errors.full_messages)
          end
        else
          render_errors(['En estos momentos no se puede efectuar el cambio de contraseña. Inténtelo de nuevo más tarde'])
        end
      }
    end
  end

end
