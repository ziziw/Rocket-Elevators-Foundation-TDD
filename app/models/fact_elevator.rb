class FactElevator < ActiveRecord::Base
    establish_connection :data_warehouse
end
