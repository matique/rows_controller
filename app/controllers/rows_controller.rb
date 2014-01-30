RAILS4 = Rails.version.to_i == 4


class RowsController < ApplicationController
  require_dependency 'rows_controller/helpers'

  # GET /:resources[.json]
  def index
    set_resources
  end

  # GET /:resource/1[.json]
  def show
    set_resource
  end

  # GET /:resource/new
  def new
    resource_new
  end

  # GET /:resource/1/edit
  def edit
    set_resource
  end

  # POST /:resources.json
  def create
    respond_to do |format|
      if resource_create
	flash[:notice] = t('ui.created', model: model_name,
		      default: "%{model} created.").html_safe
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
    set_resource
    respond_to do |format|
      if resource_update
	flash[:notice] = t('ui.updated', model: model_name).html_safe
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
    set_resource
    resource_destroy
    flash[:notice] = t('ui.destroyed', model: model_name).html_safe  unless request.xhr?
    respond_to do |format|
      format.html { redirect_to_index }
      format.js   { render template: 'rows/destroy', layout: false }
      format.json { head :no_content }
    end
  end


 private
  # Never trust parameters from the scary internet, only allow the white list through.
  def resource_params
    permits = resource_whitelist
    if RAILS4
      params.require(model_symbol).permit(permits)
    else
      pars = params[model_symbol] || {}
      pars.keys.each { |x|
	unless permits.include?(x) || permits.include?({x.to_sym => []})
	  pars.delete(x)
	  p "** WARNING: model <#{model_name}> dropping params <#{x}>"
	end
      }
      pars
    end
  end

end
