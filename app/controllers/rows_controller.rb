if Rails.version.to_i == 4
  RAILS3 = false
  RAILS4 = true
else
  RAILS3 = true
  RAILS4 = false
end


class RowsController < ApplicationController
  require_dependency 'rows_controller/helpers'

  before_action :set_resource, only: [:show, :edit, :update, :destroy] if RAILS4
  before_filter :set_resource, only: [:show, :edit, :update, :destroy] if RAILS3

  # GET /:resources[.json]
  def index
    self.resources = model_class.all
  end

  # GET /:resource/1[.json]
  def show
  end

  # GET /:resource/new
  def new
    resource_new
  end

  # GET /:resource/1/edit
  def edit
  end

  # POST /:resources.json
  def create
    respond_to do |format|
      if resource_create
	flash[:notice] = t('ui.created', model: model_name,
		      default: "%{model} created.")
	format.html {
	  if params[:commit] == 'OK'
	    redirect_to_index
	  else
	    redirect_to action: 'edit', id: resource.id
	  end
	}
	format.json { render action: 'show', status: :created, location: resource }
      else
        format.html { render action: 'new' }
	format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /:resources/1[.json]
  def update
    respond_to do |format|
      if resource_update
	flash[:notice] = t('ui.updated', model: model_name,
		      default: "%{model} updated.")
	format.html {
	  if params[:commit] == 'OK'
	    redirect_to_index
	  else
	    redirect_to action: 'edit'
	  end
	}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
	format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /:resources/1[.json]
  def destroy
    resource_destroy
    flash[:notice] = t('ui.destroyed', model: model_name)  unless request.xhr?
    respond_to do |format|
      format.html { redirect_to_index }
      format.js   { render template: 'rows/destroy' }
      format.json { head :no_content }
    end
  end


 private
  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    self.resource = model_class.find(params[:id].to_i)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def resource_params
    permits = resource_whitelist
    unless RAILS4
      pars = params[model_symbol] || {}
      pars.keys.each { |x|
	pars.delete(x)  unless permits.include?(x)
      }
      pars
    else
      params.require(model_symbol).permit(permits)
    end
  end

end
