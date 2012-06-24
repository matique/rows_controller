class RowsController < ApplicationController
  require_dependency 'rows_controller/helpers'

  respond_to :html, :xml, :json

  def index
    respond_with(resources)
  end

  def show
    respond_with(resource)
  end

  def new
    respond_with(resource)
  end

  def edit
    respond_with(resource)
  end

  def create
#    merge_bag
    msg = t('ui.created', :model => model_name,
	    :default => "%{model} created.")
    save_and_respond(msg, 'rows/new')
  end

  def update
#    merge_bag
    msg = t('ui.updated', :model => model_name,
	    :default => "%{model} updated.")
    save_and_respond(msg, 'rows/edit')
  end

  def destroy
    resource.destroy
    respond_with(resource) do |format|
      format.html { redirect_to :action => :index }
      format.js   { render :template => 'rows/destroy' }
      format.json { head :no_content }
    end
    flash[:notice] = t('ui.deleted', :model => model_name,
		       :default => "%{model} deleted.")
  end

  def copy
    @_resource = resource.dup
    @_resource.id = nil
    respond_with(resource) do |format|
      format.html { render :action => :new }
    end
  end


 private
  def save_and_respond(notice, failure_template)
    if resource.save
      respond_with(resource) do |format|
	format.html { redirect_to :action => :edit, :id => resource.id }
	format.xml  { render :xml => resource.errors, :status => :unprocessable_entity }
	format.json { head :no_content }
      end
      flash[:notice] = notice
    else
      respond_with(resource) do |format|
	format.html { render :template => failure_template, :id => resource.id }
	format.xml  { render xml:  resource.errors, :status => :unprocessable_entity }
	format.json { render json: resource.errors, :status => :unprocessable_entity }
      end
    end
  end

# May be useful:
#  def multi_deletion
#    items = params[:multi_deletion] || []
#    items -= ['']
#    items.map {|id|  model_class.find(id).destroy }
#    redirect_to :action => :index
#  end

#  def merge_bag
#    self.params = model_class.merge({}, self.params) if model_class.respond_to?(:merge)
#  end

end
