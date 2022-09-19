# frozen_string_literal: true

require "rows/resources"
require "rows/model"
require "rows/utils"

class RowsController < ApplicationController
  before_action :set_resource, only: %i[show edit update destroy]

  helper_method :resource, :resources
  helper_method :resource_columns, :resource_format
  helper_method :model_class, :model_name
  helper_method :model_symbol, :model_symbol_plural

  include Rows::Model
  include Rows::Resources
  include Rows::Utils

  def self.model_class(model_class = nil)
    return @_model_class if model_class.nil?

    @_model_class = model_class
    @_model_class = model_class.constantize  if model_class.is_a?(String)
  end

  def index
    rows = model_class.all
    instance_variable_set("@#{model_symbol_plural}", rows) if rows
    @_resources = rows
  end

  def show
  end

  def new
    @_resource = model_class.new
    instance_variable_set("@#{model_symbol}", resource) if resource
  end

  def edit
  end

  def create
    @_resource = model_class.new(resource_params)
    instance_variable_set("@#{model_symbol}", resource) if resource
    @row = @_resource
    msg = t("ui.created", model: model_name)
    if resource.save
      succeded msg, :create
    else
      failed :edit
    end
  end

  def update
    msg = t("ui.update", model: model_name)
    if resource.update(resource_params)
      succeded msg, :ok
    else
      failed :edit
    end
  end

  def destroy
    resource.destroy
    msg = t("ui.destroyed", model: model_name)
    flash[:notice] = msg unless request.xhr?
    respond_to do |format|
      format.html { redirect_to action: :index }
      format.json { head :no_content }
    end
  end

  private

  def succeded(msg, next_status)
    respond_to do |format|
      format.html {
        flash[:notice] = msg
        if params[:commit] == "OK"
          redirect_to action: :index
        else
          redirect_to action: :edit, id: resource.id
        end
      }
      format.json {
        render action: :show, status: next_status, location: resource
      }
    end
  end

  def failed(next_action)
    respond_to do |format|
      format.html { render action: next_action }
      format.json {
        render json: resource.errors, status: :unprocessable_entity
      }
    end
  end

  def xcreate_update(which, msg)
    respond_to do |format|
      if send(which)
        format.html {
          flash[:notice] = t(msg, scope: :ui, model: model_name,
            default: "%{model} was successfully #{msg}.").html_safe
          if params[:commit] == "OK"
            redirect_to action: :index
          else
            redirect_to action: "edit", id: resource.id
          end
        }
        format.json {
          render action: "show",
            status: msg == "created" ? :created : :ok,
            location: resource
        }
      else # failed
        format.html { render action: msg == "created" ? :new : :edit }
        format.json {
          render json: resource.errors, status: :unprocessable_entity
        }
      end
    end
  end

  def set_resource
    id = params[:id]
    @_resource = model_class.find_by(id: id) if id
    instance_variable_set("@#{model_symbol}", resource) if resource
    @row = resource
  end
end
