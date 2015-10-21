class Order::ItemsController < RowsController

 private
  def resource_whitelist
    %i{ name }
  end

end
