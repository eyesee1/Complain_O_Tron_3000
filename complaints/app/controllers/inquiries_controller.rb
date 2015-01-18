class InquiriesController < ApplicationController
  layout "complainers"
  before_filter :login_required, :only => [ :edit, :update, :destroy, :index, :show ]  
  require_role "admin", :for => [:edit, :update, :destroy, :index, :show] 
  # GET /inquiries
  # GET /inquiries.xml
  def index
    # @inquiries = Inquiry.find(:all)
    @inquiries = Inquiry.paginate :page => params[:page], :order => 'created_at DESC'
    respond_to do |format|
      format.html { render :layout => 'application'} # index.html.erb
      format.xml  { render :xml => @inquiries }
    end
  end

  # GET /inquiries/1
  # GET /inquiries/1.xml
  def show
    @inquiry = Inquiry.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'application' } # show.html.erb
      format.xml  { render :xml => @inquiry }
    end
  end

  # GET /inquiries/new
  # GET /inquiries/new.xml
  def new
    @inquiry = Inquiry.new
    if session[:location]
      @inquiry.location_entry = session[:location]
    end
    respond_to do |format|
      format.html #{ render :layout => 'complainers'}
      format.xml  { render :xml => @inquiry }
    end
  end

  # GET /inquiries/1/edit
  def edit
    @inquiry = Inquiry.find(params[:id])
  end

  # POST /inquiries
  # POST /inquiries.xml
  def create
    @inquiry = Inquiry.new(params[:inquiry])
    @inquiry.update_attributes geo_lookup @inquiry.location_entry
    session[:location] = @inquiry.nice_location
    respond_to do |format|
      if @inquiry.save
        flash[:notice] = 'Inquiry was successfully sent.'
        format.html { redirect_to('/') }
        format.xml  { render :xml => @inquiry, :status => :created, :location => @inquiry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inquiry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inquiries/1
  # PUT /inquiries/1.xml
  def update
    @inquiry = Inquiry.find(params[:id])
    @inquiry.update_attributes geo_lookup @inquiry.location_entry
    # don't store location to session here because this will only be an admin user
    respond_to do |format|
      if @inquiry.update_attributes(params[:inquiry])
        flash[:notice] = 'Inquiry was successfully updated.'
        format.html { redirect_to(@inquiry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inquiry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inquiries/1
  # DELETE /inquiries/1.xml
  def destroy
    @inquiry = Inquiry.find(params[:id])
    @inquiry.destroy

    respond_to do |format|
      format.html { redirect_to(inquiries_url) }
      format.xml  { head :ok }
    end
  end
end
