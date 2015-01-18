class FaqsController < ApplicationController
  layout "application"
  before_filter :login_required, :only => [ :edit, :update, :destroy, :index, :show ]  
  
  def list
    @faqs = Faq.paginate :page => params[:page], :order => 'position'
    respond_to do |format|
      format.html { render :layout => 'layouts/complainers' }
      format.xml  { render :xml => @faqs }
    end
  end
  
  def index
    @faqs = Faq.paginate :page => params[:page], :order => 'position'
    respond_to do |format|
      format.html { render :layout => 'layouts/application' }
      format.xml  { render :xml => @faqs }
    end
  end

  def move_higher
    @faq = Faq.find(params[:id])
    @faq.move_higher
    respond_to do |format|
        format.html { redirect_to(:action => :index) }
    end
  end

  def move_lower
    @faq = Faq.find(params[:id])
    @faq.move_lower
    respond_to do |format|
        format.html { redirect_to(:action => :index) }
    end
  end

  def show
    @faq = Faq.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @faq }
    end
  end

  # GET /faqs/new
  # GET /faqs/new.xml
  def new
    @faq = Faq.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @faq }
    end
  end

  # GET /faqs/1/edit
  def edit
    @faq = Faq.find(params[:id])
  end

  # POST /faqs
  # POST /faqs.xml
  def create
    @faq = Faq.new(params[:faq])

    respond_to do |format|
      if @faq.save
        flash[:notice] = 'Faq was successfully created.'
        format.html { redirect_to(@faq) }
        format.xml  { render :xml => @faq, :status => :created, :location => @faq }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @faq.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /faqs/1
  # PUT /faqs/1.xml
  def update
    @faq = Faq.find(params[:id])

    respond_to do |format|
      if @faq.update_attributes(params[:faq])
        flash[:notice] = 'Faq was successfully updated.'
        format.html { redirect_to(@faq) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @faq.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /faqs/1
  # DELETE /faqs/1.xml
  def destroy
    @faq = Faq.find(params[:id])
    @faq.destroy

    respond_to do |format|
      format.html { redirect_to(faqs_url) }
      format.xml  { head :ok }
    end
  end
end
