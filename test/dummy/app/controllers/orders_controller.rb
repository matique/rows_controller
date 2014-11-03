class OrdersController < RowsExtController

 private
  def resource_whitelist
    %w{name qty}
  end

  def resource_columns
    [:multi_selection] + super
  end

end
