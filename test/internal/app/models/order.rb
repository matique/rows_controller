class Order < ApplicationRecord
  validates :name, presence: true

  before_save do |row|
    throw :abort if row.name == "error"
  end
end
