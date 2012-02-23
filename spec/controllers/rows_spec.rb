require 'spec_helper'

describe RowsController do
  specify { should respond_to(:resource) }
  specify { should respond_to(:resources) }
  specify { should respond_to(:model_class) }
  specify { should respond_to(:model_name) }
  specify { should respond_to(:model_symbol) }
  specify { should respond_to(:model_symbol_plural) }
  specify { should respond_to(:resource_format) }

  specify { should respond_to(:index) }
  specify { should respond_to(:show) }
  specify { should respond_to(:new) }
  specify { should respond_to(:edit) }
  specify { should respond_to(:create) }
  specify { should respond_to(:update) }
  specify { should respond_to(:destroy) }
end
