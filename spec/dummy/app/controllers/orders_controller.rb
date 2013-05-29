class OrdersController < RowsController

 private
  def resource_whitelist
    %w{name value}
  end

end
