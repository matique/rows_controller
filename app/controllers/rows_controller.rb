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

    if resource_create
      flash[:notice] = t('ui.created', model: model_name,
	      default: "%{model} created.")
      respond_with(resource) do |format|
	format.html { redirect_to_commit }
	format.xml  { render xml: resource, status: :created, location: self.model }
	format.json { head :no_content }
      end
    else
      respond_with(resource) do |format|
	format.html { render template: 'rows/new' }
	format.xml  { render xml: resource.errors, status: :unprocessable_entity }
	format.json { head :no_content }
      end
    end
  end

  def update
#    merge_bag

    if resource_update
      flash[:notice] = t('ui.updated', model: model_name,
	    default: "%{model} updated.")
      respond_with(resource) do |format|
	format.html { redirect_to_commit }
	format.xml  { head :ok }
	format.json { head :no_content }
      end
    else
      respond_with(resource) do |format|
	format.html { render template: 'rows/edit' }
	format.xml  { render xml: resource.errors, status: :unprocessable_entity }
	format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end

#    msg = t('ui.updated', :model => model_name,
#            :default => "%{model} updated.")
#    flash[:notice] = msg  if resource_update
#    respond_with(resource)
  end

  def destroy
    resource_destroy
    respond_with(resource) do |format|
      format.html { redirect_to_index }
      format.js   { render template: 'rows/destroy' }
      format.json { head :no_content }
    end
    flash[:notice] = t('ui.deleted', model: model_name,
		       default: "%{model} deleted.")
  end


 private

# May be useful:
#  def merge_bag
#    self.params = model_class.merge({}, self.params) if model_class.respond_to?(:merge)
#  end

end
