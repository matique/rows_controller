class Order < ApplicationRecord

  before_save :err

 protected
  def err
    if name == 'error'
      throw :abort
    end
  end

end
