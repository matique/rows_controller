class Order < ApplicationRecord

  before_save do |row|
    throw :abort  if row.name == 'error'
  end

end
