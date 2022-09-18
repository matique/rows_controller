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
    if resource.save
      flash[:notice] = t("ui.created", model: model_name)
      respond_to do |format|
        format.html { redirect_to action: :index }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if resource.update(resource_params)
      flash[:notice] = t("ui.update", model: model_name)
      respond_to do |format|
        format.html { redirect_to action: :index }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    resource.destroy
    msg = t("ui.destroyed", model: model_name)
    flash[:notice] = msg unless request.xhr?
    respond_to do |format|
      format.html { redirect_to action: :index }
      format.turbo_stream
    end
  end

  private

  def set_resource
    id = params[:id]
    @_resource = model_class.find_by(id: id) if id
    instance_variable_set("@#{model_symbol}", resource) if resource
    @row = resource
  end
end
