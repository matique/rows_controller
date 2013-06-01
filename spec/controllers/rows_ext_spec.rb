require 'spec_helper'

describe RowsExtController do
  specify { should respond_to(:copy) }
  specify { should respond_to(:multi_deletion) }
end
