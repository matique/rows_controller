# frozen_string_literal: true

module Rows::Resources
  def resource
    @_resource || set_resource
  end

  def resources
    @_resources || set_resources
  end

  def set_resource(row = nil)
    row ||= model_class.find_by_id(params[:id].to_i)
    instance_variable_set(:"@#{model_symbol}", row)
    @_resource = row
    @row = row
  end

  def set_resources(rows = nil)
    rows ||= model_class.all
    instance_variable_set(:"@#{model_symbol_plural}", rows)
    @_resources = rows
    @rows = rows
  end

  private

  def resource_columns
    return model_class.column_headers if model_class.respond_to?(:column_headers)
    return ["to_s"] unless model_class.respond_to?(:content_columns)

    ["id"] + model_class.content_columns.collect(&:name)
  end

  def resource_whitelist
    raise "TurbocController requires private method 'resource_whitelist' in controller <#{params[:controller]}>"
  end

  # Never trust parameters from the scary internet, only allow the
  # white list through.
  def resource_params
    permits = resource_whitelist
    params.require(model_symbol).permit(permits)
  end
end
