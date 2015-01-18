class ComplaintsController < ApplicationController
  layout "application"
  
  before_filter :login_required, :only => [ :edit, :update, :destroy, :index ]  
  require_role "admin", :for => [:edit, :update, :destroy, :index] 
  # require_role "admin", :for => :show, :unless => "session[:complaint_ids] and session[:complaint_ids].index(params[:id]) != nil"
  # GET /complaints
  # GET /complaints.xml
  def index
    @complaints = Complaint.paginate :page => params[:page], :order => 'created_at DESC'
    @page_title = 'Complaint Processing Center'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @complaints }
    end
  end

  # GET /complaints/1
  # GET /complaints/1.xml
  def show
    puts 'session complaint ids:'
    puts session[:complaint_ids].to_s
    allowed = false
    if session[:complaint_ids]
      puts session[:complaint_ids].length
      for i in session[:complaint_ids]
        if i.to_s.eql? params[:id]
          allowed = true
        end
      end
    end
    puts 'allowed? ', allowed
    puts 'current user: ', current_user
    if not allowed
      puts 'I AM ABORTING!'
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
      return nil
    else
      puts 'apparently this is allowed!?'
    end
    @complaint = Complaint.find(params[:id])
    @page_title = 'Complaint Received.'
    respond_to do |format|
      format.html  { render :layout => 'layouts/complainers' }  # show.html.erb
      format.xml  { render :xml => @complaint }
    end
  end

  # GET /complaints/new
  # GET /complaints/new.xml
  def new
    @complaint = Complaint.new
    @page_title = 'Complain Here.'
    if session[:location]
      @complaint.location_entry = session[:location]
    end
    # my layout "complainers"
    respond_to do |format|
      format.html { render :layout => 'layouts/complainers' }  # new.html.erb
      format.xml  { render :xml => @complaint }
    end
  end

  # GET /complaints/1/edit
  def edit
    @complaint = Complaint.find(params[:id])
  end

  # POST /complaints
  # POST /complaints.xml
  def create
    @complaint = Complaint.new(params[:complaint])
    @complaint.update_attributes(geo_lookup(@complaint.location_entry))
    session[:location] = @complaint.nice_location
    respond_to do |format|
      if @complaint.save
        if session[:complaint_ids]
          session[:complaint_ids].push(@complaint.id)
        else
          session[:complaint_ids] = [@complaint.id]
        end
        # flash[:notice] = 'Complaint was successfully created.'
        format.html { redirect_to(@complaint) }
        format.xml  { render :xml => @complaint, :status => :created, :location => @complaint }
      else
        format.html { render :action => "new", :layout => 'layouts/complainers' }
        format.xml  { render :xml => @complaint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /complaints/1
  # PUT /complaints/1.xml
  def update
    @complaint = Complaint.find(params[:id])
    respond_to do |format|
      if @complaint.update_attributes(params[:complaint])
        flash[:notice] = 'Complaint was successfully updated.'
        @complaint.update_attributes(geo_lookup(@complaint.location_entry))
        format.html { redirect_to(complaints_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @complaint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /complaints/1
  # DELETE /complaints/1.xml
  def destroy
    @complaint = Complaint.find(params[:id])
    @complaint.destroy
    flash[:notice] = 'Complaint was destroyed.'
    respond_to do |format|
      format.html { redirect_to(complaints_url) }
      format.xml  { head :ok }
    end
  end
end
