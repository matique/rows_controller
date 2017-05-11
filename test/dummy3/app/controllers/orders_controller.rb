class OrdersController < RowsExtController

 private
  def resource_whitelist
    %i{ name }
  end

end
