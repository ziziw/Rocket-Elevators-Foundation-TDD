class Intervention < ApplicationRecord
  belongs_to :customer
  belongs_to :building
  belongs_to :battery
  belongs_to :column
  belongs_to :elevator
  belongs_to :employee
end
