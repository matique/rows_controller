class OrdersController < RowsController
  private

  def resource_whitelist
    %i[name]
  end
end
