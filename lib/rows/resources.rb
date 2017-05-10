module Rows::Resources

  def set_resources(rows = nil)
    rows ||= model_class.all
    instance_variable_set("@#{model_symbol_plural}", rows)
    @rows = rows
  end

  def set_resource(row = nil)
    row ||= model_class.find_by_id(params[:id].to_i)
    instance_variable_set("@#{model_symbol}", row)
    @row = row
  end

  def resources
    @rows || set_resources
  end

  def resource
    @row || set_resource
  end

 private
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
    if Rails::VERSION::MAJOR >= 4
      return true  unless params[model_symbol]
      resource.update(resource_params)
    else
      resource.update_attributes(resource_params)
    end
  end

  def resource_destroy
    resource.destroy
  end

  def resource_columns
    return model_class.column_headers  if model_class.respond_to?(:column_headers)
    return ['to_s']  unless model_class.respond_to?(:content_columns)
    ['id'] + model_class.content_columns.collect{|c| c.name }
  end

  def resource_whitelist
    raise "RowsController requires private method 'resource_whitelist' in controller <#{params[:controller]}>"
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def resource_params
    permits = resource_whitelist
    if Rails::VERSION::MAJOR > 3
      params.require(model_symbol).permit(permits)
    else
      pars = params[model_symbol] || {}
      pars.keys.each { |x|
	x = x.to_sym
	unless permits.include?(x) || permits.include?({x => []})
	  pars.delete(x)
	  p "** WARNING: model <#{model_name}> dropping params <#{x}>"
	end
      }
      pars
    end
  end

end
