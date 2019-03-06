# frozen_string_literal: true

require 'rows/resources'
require 'rows/model'
require 'rows/utils'

class RowsController < ApplicationController
  helper_method :set_resource, :set_resources, :resource, :resources
  helper_method :resource_columns, :resource_format
  helper_method :model_class, :model_name
  helper_method :model_symbol, :model_symbol_plural

  include Rows::Model
  include Rows::Resources
  include Rows::Utils

  def self.model_class(model_class = nil)
    @_model_class ||= nil
    unless model_class.nil?
      @_model_class = model_class
      @_model_class = model_class.constantize  if model_class.is_a?(String)
    end
    @_model_class
  end

  # GET /:resources[.json]
  def index
    set_resources
  end

  # GET /:resource/:id[.json]
  def show
    set_resource
  end

  # GET /:resource/new
  def new
    resource_new
  end

  # GET /:resource/:id/edit
  def edit
    set_resource
  end

  # POST /:resources[.json]
  def create
    create_update(:resource_create, 'created')
  end

  # PATCH/PUT /:resources/:id[.json]
  def update
    set_resource
    create_update(:resource_update, 'updated')
  end

  # DELETE /:resources/:id[.json]
  def destroy
    set_resource
    resource_destroy
    msg = t('ui.destroyed', model: model_name).html_safe
    flash[:notice] = msg  unless request.xhr?
    respond_to do |format|
      format.html { redirect_to action: :index }
      format.js   { render template: 'rows/destroy', layout: false }
      format.json { head :no_content }
    end
  end

 private
  def create_update(which, msg)
    respond_to do |format|
      if send(which)
	format.html {
	  flash[:notice] = t(msg, scope: :ui, model: model_name,
		  default: "%{model} was successfully #{msg}.").html_safe
	  if params[:commit] == 'OK'
	    redirect_to action: :index
	  else
	    redirect_to action: 'edit', id: resource.id
	  end
	}
	format.json { render action: 'show',
			status: msg == 'created' ? :created : :ok,
			location: resource }
      else  ## failed
	format.html { render action: msg == 'created' ? :new : :edit }
	format.json { render json: resource.errors,
			     status: :unprocessable_entity }
      end
    end
  end

end
