# frozen_string_literal: true

require "rows/resources"
require "rows/model"
require "rows/utils"

class RowsController < ApplicationController
  before_action :set_resource, only: %i[show edit update destroy]

  helper_method :resource, :resources, :set_resource, :set_resources
  helper_method :resource_columns, :resource_format
  helper_method :model_class, :model_name
  helper_method :model_symbol, :model_symbol_plural

  include Rows::Model
  include Rows::Resources
  include Rows::Utils

  def self.model_class(model_class = nil)
    return @_model_class if model_class.nil?

    @_model_class = model_class
    @_model_class = model_class.constantize if model_class.is_a?(String)
  end

  def index
    set_resources model_class.all
  end

  def show
  end

  def new
    set_resource model_class.new
  end

  def edit
  end

  def create
    set_resource model_class.new(resource_params)
    msg = t("ui.created", model: model_name)
    if resource.save
      succeded msg, :create
    else
      failed :edit
    end
  end

  def update
    msg = t("ui.updated", model: model_name)
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
      # format.turbo_stream {} # outcomment for backward compatibility
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
end
