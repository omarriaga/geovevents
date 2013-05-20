class ApplicationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @applications = Application.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @application = Application.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @application = Application.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @application = Application.find(params[:id])
  end

  def create
    @application = Application.new(params[:application])

    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, notice: 'Application was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @application = Application.find(params[:id])

    respond_to do |format|
      if @application.update_attributes(params[:application])
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    respond_to do |format|
      format.html { redirect_to applications_url }
    end
  end
end
