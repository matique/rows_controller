class Order < ActiveRecord::Base

  before_save :huhu
  def huhu
    return true  unless name == 'error'

    self.errors.add :base, 'panic'
    return false
  end

end
