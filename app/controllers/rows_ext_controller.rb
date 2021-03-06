# frozen_string_literal: true

# Extensions
class RowsExtController < RowsController

  def copy
    set_resource resource.dup
    resource.id = nil
    respond_to do |format|
      format.html { render action: :new }
    end
  end

  def multi_deletion
    items = params[:multi_tick] || []
    items -= ['']
    items.map { |id|  model_class.find_by_id(id.to_i).destroy }
    redirect_to action: :index
  end

end
