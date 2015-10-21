module Rows::Model

  def model_class
    @_model_class  ||= self.class.model_class ||
		       params[:controller].singularize.camelize.constantize
  end

  def model_name
    @_model_name   ||= model_class.model_name.name
  end

  def model_symbol
    @_model_symbol ||= model_class.model_name.singular
  end

  def model_symbol_plural
    @_model_symbol_plural ||= model_class.model_name.plural
  end

end
