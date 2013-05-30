class RowsController < ApplicationController
  helper_method :resource, :resources, :resource_columns, :resource_format
  helper_method :model_class, :model_name, :model_symbol, :model_symbol_plural

# resources/@rows
  def resources
    @rows
  end

  def resources=(value)
    instance_variable_set("@#{model_symbol_plural}", value)
    @rows = value
  end

  def resource
    @row
  end

  def resource=(value)
    instance_variable_set("@#{model_symbol}", value)
    @row = value
  end

  def resource_columns
    return model_class.column_headers  if model_class.respond_to?(:column_headers)
    return ['to_s']  unless model_class.respond_to?(:content_columns)
    ['id'] + model_class.content_columns.collect{|c| c.name }
  end

 private
  def resource_whitelist
    raise "RowsController requires private method 'resource_whitelist' in controller <#{params[:controller]}>"
  end


 public
# low level resource methods
# can be monkey patched
  def resource_new
    if params[model_symbol]
      self.resource = model_class.new(resource_params)
    else
      self.resource = model_class.new
    end
  end

  def resource_create
    resource_new
    resource.save
  end

  def resource_update
    unless RAILS4
      resource.update_attributes(resource_params)
    else
      resource.update(resource_params)
    end
  end

  def resource_destroy
    resource.destroy
  end


# redirections
# can be monkey patched
  def redirect_to_index
    redirect_to action: 'index'
  end


# dynamic model related methods
  def self.model_class(model_class = nil)
    @model_class = model_class  unless model_class.nil?
    @model_class
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

# formatting
  def resource_format(x)
    return '--'.html_safe  if x.nil?
    bool = x.class == Time || x.class == Date || x.class == DateTime ||
	   x.class == ActiveSupport::TimeWithZone
#    return x.strftime(DATE_FORMAT).html_safe  if bool
#    return x.strftime('%d.%m.%Y').html_safe  if bool
    return I18n.l(x)                if bool
    return x.to_s.html_safe         if x.class == Fixnum
    return 'X'.html_safe            if x.class == TrueClass
    return '&ensp;'.html_safe       if x.class == FalseClass
    return x.call                   if x.class == Proc
    return '---'.html_safe          if x.empty?
    str = x.to_s
    return str.gsub(/\r*\n/, '<br/>')
  end

end
