class RowsExtController < RowsController

  def copy
    @_resource = resource.dup
    @_resource.id = nil
    respond_with(resource) do |format|
      format.html { render :action => :new }
    end
  end

# May be useful:
#  def multi_deletion
#    items = params[:multi_deletion] || []
#    items -= ['']
#    items.map {|id|  model_class.find(id).destroy }
#    redirect_to :action => :index
#  end

end
