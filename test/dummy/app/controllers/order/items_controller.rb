class Order::ItemsController < RowsController

 private
  def resource_whitelist
    %w{name}
  end

end
