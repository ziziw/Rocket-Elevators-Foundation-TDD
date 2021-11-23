class FactQuote < ActiveRecord::Base
    establish_connection :data_warehouse
end
