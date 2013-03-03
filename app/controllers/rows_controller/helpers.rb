class RowsController < ApplicationController

  def self.model_class(model_class = nil)
    @model_class = model_class  unless model_class.nil?
    @model_class
  end


 private
  def resource_new
    resource = model_class.new(params[model_symbol])
  end

  def resource_create
    resource.save
  end

  def resource_update
    resource.save
  end

  def resource_destroy
    resource.destroy
  end

  def redirect_to_index
    redirect_to action: :index
  end

  def redirect_to_commit
    redirect_to action: :edit, id: resource.id
  end

  
 protected
  DATE_FORMAT = '%d.%m.%Y'

  helper_method :resource, :resources, :columns,
    :model_class, :model_name, :model_symbol, :model_symbol_plural,
    :resource_format

  def resource
    return @_resource  if @_resource

    self.resource = begin
      name = model_symbol
      if id = params["#{name}_id"] || params[:id]
	model_class.find_by_id(id).tap do |r|
	  r.attributes = params[name] unless request.get?
	end
      else
	model_class.new(params[name])
      end
    end
  end

  def resource=(value)
    @_resource = value
    @row = value
    instance_variable_set("@#{model_symbol}", value)
    value
  end

  def resources
    return @_resources  if @_resources
    self.resources = model_class.all
  end

  def resources=(value)
    @_resources = value
    @rows = value
    instance_variable_set("@#{model_symbol_plural}", value)
    value
  end

  def model_class
    @model_class ||= self.class.model_class ||
		     params[:controller].singularize.camelize.constantize
  end

  def model_name
    @_model_name ||= model_class.name
  end

  def model_symbol
    @_model_symbol ||= model_name.underscore
  end

  def model_symbol_plural
    @_model_symbol_plural ||= model_name.pluralize.underscore
  end

  def columns
    return model_class.column_headers  if model_class.respond_to?(:column_headers)
    return ['to_s']  unless model_class.respond_to?(:content_columns)
    ['id'] + model_class.content_columns.collect{|c| c.name }
  end

  def resource_format(x)
    x = ''.html_safe  if x.nil?
    bool = x.class == Time || x.class == Date || x.class == DateTime ||
	   x.class == ActiveSupport::TimeWithZone
    return x.strftime(DATE_FORMAT).html_safe  if bool
    return x.to_s.html_safe         if x.class == Fixnum
    return 'X'.html_safe            if x.class == TrueClass
    return '&ensp;'.html_safe       if x.class == FalseClass
    return x.call                   if x.class == Proc
    return '---'.html_safe          if x.empty?
    str = x.to_s
##    str = UTF8FY.iconv(x.to_s)  if APPLICATION_OPTIONS[:customization] == :dk
    return str.gsub(/\r*\n/, '<br/>')
  end

end
