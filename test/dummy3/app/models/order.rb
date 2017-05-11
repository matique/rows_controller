class Order < ActiveRecord::Base
  attr_accessible :name

  before_save :err

 protected
  def err
    return true  unless name == 'error'

    self.errors.add :base, 'panic'
    return false
  end

end
