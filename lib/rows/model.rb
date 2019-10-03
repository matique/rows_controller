module Rows::Model

  def model_class
    @_model_class ||= self.class.model_class ||
                      params[:controller].singularize.camelize.constantize
  end

  if Rails::VERSION::MAJOR > 3
    def model_name
      @_model_name ||= model_class.model_name.name
    end

    def model_symbol
      @_model_symbol ||= model_class.model_name.singular
    end
  else
    def model_name
      @_model_name ||= model_class.name
    end

    def model_symbol
      @_model_symbol ||= model_name.underscore.gsub(%r{/}, '_')
    end
  end

  def model_symbol_plural
    @_model_symbol_plural ||= model_symbol.pluralize
  end

end
