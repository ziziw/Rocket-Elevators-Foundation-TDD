class FactElevator < ActiveRecord::Base
    has_one :elevator
    establish_connection :data_warehouse
end
