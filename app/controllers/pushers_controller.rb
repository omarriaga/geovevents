class PushersController < ApplicationController

  before_filter :authenticate_user!

  before_filter :find_application

  def index
    @pushers = @application.pushers.all :order => "created_at DESC"
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @pusher = @application.pushers.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @pusher = @application.pushers.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @pusher = @application.pushers.find(params[:id])
  end

  def create
    @pusher = @application.pushers.new(params[:pusher])
    respond_to do |format|
      if @pusher.save
        format.html { redirect_to [@application, @pusher], notice: 'Pusher was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @pusher = @application.pushers.find(params[:id])
    respond_to do |format|
      if @pusher.update_attributes(params[:pusher])
        format.html { redirect_to [@application, @pusher], notice: 'Pusher was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @pusher = @application.pushers.find(params[:id])
    @pusher.destroy
    respond_to do |format|
      format.html { redirect_to application_pushers_path(@application) }
    end
  end

private
  def find_application
    @application = Application.find(params[:application_id])
  end

end
