class RowsController < ApplicationController
  helper_method :set_resource, :set_resources
  helper_method :resource, :resources, :resource_columns, :resource_format
  helper_method :model_class, :model_name, :model_symbol, :model_symbol_plural

# resources/@rows
  def set_resources(rows = nil)
    rows ||= model_class.all
    instance_variable_set("@#{model_symbol_plural}", rows)
    @rows = rows
  end

  def set_resource(row = nil)
    row ||= model_class.find(params[:id].to_i)
    instance_variable_set("@#{model_symbol}", row)
    @row = row
  end

  def resources
    @rows || set_resources
  end

  def resource
    @row || set_resource
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
      set_resource model_class.new(resource_params)
    else
      set_resource model_class.new
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
p 1111111111111111
#    @_model_name ||= model_class.name
p [11, model_class.model_name.singular]
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
    return x.strftime('%d.%m.%Y').html_safe  if bool
#    return I18n.l(x)                if bool
    return x.to_s.html_safe         if x.class == Fixnum
    return 'X'.html_safe            if x.class == TrueClass
    return '&ensp;'.html_safe       if x.class == FalseClass
    return x.call                   if x.class == Proc
    return '---'.html_safe          if x.empty?
    str = x.to_s
    return str.gsub(/\r*\n/, '<br/>')
  end

end
