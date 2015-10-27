class Order::ItemsController < RowsController

 private
  def resource_whitelist
    %i{ price }
  end

end
