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
    resource_new
    respond_with(resource)
  end

  def edit
    respond_with(resource)
  end

  def create
#    merge_bag
    resource = model_class.new(params[model_symbol])

    msg = t('ui.created', :model => model_name,
	    :default => "%{model} created.")
    flash[:notice] = msg  if resource_create
    respond_with(resource)
  end

  def update
#    merge_bag
    msg = t('ui.updated', :model => model_name,
	    :default => "%{model} updated.")
    flash[:notice] = msg  if resource_update
    respond_with(resource)
  end

  def destroy
    resource_destroy
    respond_with(resource) do |format|
      format.html { redirect_to_index }
      format.js   { render :template => 'rows/destroy' }
      format.json { head :no_content }
    end
    flash[:notice] = t('ui.deleted', :model => model_name,
		       :default => "%{model} deleted.")
  end


 private
#  def save_and_respond(notice, failure_template)
#    if resource_save
#      respond_with(resource) do |format|
#        format.html { redirect_to :action => :edit, :id => resource.id }
#        format.xml  { render :xml => resource.errors, :status => :unprocessable_entity }
#        format.json { head :no_content }
#      end
#      flash[:notice] = notice
#    else
#      respond_with(resource) do |format|
#        format.html { render :template => failure_template, :id => resource.id }
#        format.xml  { render xml:  resource.errors, :status => :unprocessable_entity }
#        format.json { render json: resource.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

# May be useful:
#  def merge_bag
#    self.params = model_class.merge({}, self.params) if model_class.respond_to?(:merge)
#  end

end
