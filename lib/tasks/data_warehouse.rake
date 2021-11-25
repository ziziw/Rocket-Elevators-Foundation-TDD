require File.expand_path(File.dirname(__FILE__) + '/../../config/environment.rb')
require 'pg'
require "faker"


connection = PG::Connection.new(host:'localhost',port:'5432',dbname:'data_warehouse',user:'longnguyen',password:'')

puts "\e[0;36mCurrently connected to:\e[0m '" + ActiveRecord::Base.connection.current_database + "'"
puts "\e[0;36mCurrently connected for PG to:\e[0m '" + connection.db + "'"



def get_total_ele( customer_id)
    elevator_total = 0
    Customer.find(customer_id).buildings.all.each do |building|
        building.batteries.all.each do |battery|
            battery.columns.all.each do |column|
                column.elevators.all.each do |elevator|
                    elevator_total += 1
                end
            end
        end
    end
    return elevator_total
end


namespace :wh do
    task :reset do
        Rake::Task["wh:make_table"].invoke
        Rake::Task["wh:populate:quote"].invoke
        Rake::Task["wh:populate:contact"].invoke
        Rake::Task["wh:populate:elevator"].invoke
        Rake::Task["wh:populate:customer"].invoke
        Rake::Task["wh:populate:intervention"].invoke
    end




        task make_table: :environment do
            connection.exec("DROP TABLE IF EXISTS public.fact_quotes")
            connection.exec("CREATE TABLE public.fact_quotes (creation_date date NULL, id serial,
            company_name varchar NULL,
            email varchar NULL,
            nb_elevator int4 NULL,
            quote_id serial NOT NULL,
            CONSTRAINT fact_quotes_pk PRIMARY KEY (quote_id))")
            print "CREATE FACT QUOTE TABLE: "
            puts "\e[0;32mOK\e[0m"

            connection.exec("DROP TABLE IF EXISTS public.fact_contacts")
            connection.exec("CREATE TABLE public.fact_contacts (creation_date date NULL, id serial,
            company_name varchar NULL,
            email varchar NULL,
            project_name varchar NULL,
            contact_id serial NOT NULL,
            CONSTRAINT fact_contact_pk PRIMARY KEY (contact_id))")
            print "CREATE FACT CONTACT TABLE: "
            puts "\e[0;32mOK\e[0m"


            connection.exec("DROP TABLE IF EXISTS public.fact_elevators")
            connection.exec("CREATE TABLE public.fact_elevators (date_of_commissionig date NULL, id serial,
            building_city varchar NULL,
            customer_id serial NOT NULL,
            building_id serial NOT NULL,
            serial_number serial NOT NULL,
            CONSTRAINT fact_elevator_pk PRIMARY KEY (serial_number))")
            print "CREATE FACT ELEVATOR TABLE: "
            puts "\e[0;32mOK\e[0m"

            

            connection.exec("DROP TABLE IF EXISTS public.dim_customers")
            connection.exec("CREATE TABLE public.dim_customers (creation_date date NULL, id serial,
            company_name varchar NULL,
            email varchar NULL,
            full_name varchar NULL,
            nb_elevator int4 NULL,
            customer_city varchar NULL)")
            print "CREATE DIM CUSTOMER TABLE: "
            puts "\e[0;32mOK\e[0m"

            connection.exec("DROP TABLE IF EXISTS public.fact_interventions")
            connection.exec("CREATE TABLE public.fact_interventions (creation_date date NULL,
            intervention_id serial NOT NULL,
            employee_id int NOT NULL,
            building_id int NOT NULL,
            battery_id int ,
            column_id int ,
            elevator_id int ,
            start_intervention timestamp without time zone NOT NULL,
            end_intervention timestamp without time zone ,
            result varchar NOT NULL,
            report varchar ,
            status varchar NOT NULL,
            CONSTRAINT fact_intervention_pk PRIMARY KEY (intervention_id))")
            print "CREATE FACT INTERVENTIONS TABLE: "
            puts "\e[0;32mOK\e[0m"
        end

        namespace :populate do
            task quote: :environment do
                Quote.all.each do |quote|
                    query = "insert into fact_quotes(quote_id,creation_date , company_name, email, nb_elevator ) values('#{quote.id}', '#{quote.created_at}',' #{quote.email}', '#{quote.company_name.gsub("'", "''")}', '#{quote.amount_elevators}')"
                connection.exec(query)
                end
                puts "POPULATE FACT QUOTE: " + "\e[0;32mOK\e[0m"
            end


            task contact: :environment do
                Lead.all.each do |contact|
                    query = "insert into fact_contacts(contact_id, creation_date, company_name, email, project_name) values('#{contact.id}', '#{contact.date_of_creation}', '#{contact.company_name}', '#{contact.email}', '#{contact.project_name}')"
                    connection.exec(query)
                end
                puts "POPULATE FACT CONTACT: " + "\e[0;32mOK\e[0m"
            end
            task elevator: :environment do
                

                Building.all.each do |building|
                    @address = Address.find(building.address_id)
                    building.batteries.all.each do |battery|
                        battery.columns.all.each do |column|
                            column.elevators.all.each do |elevator|
                                query = "insert into fact_elevators(serial_number, date_of_commissionig, building_city, customer_id, building_id) values('#{elevator.id}', '#{elevator.Date_of_commissioning}', '#{@address.city}', '#{building.customer.id}', '#{building.id}')"
                                connection.exec(query)
                            end
                        end
                    end
                end

                puts "POPULATE FACT ELEVATOR: " + "\e[0;32mOK\e[0m"
            end
            task customer: :environment do
                Customer.all.each do |customer|
                    query = "insert into dim_customers(creation_date, company_name, full_name, email, nb_elevator, customer_city) values('#{customer.customer_creation_date}', '#{customer.company_name.gsub("'", "''")}', '#{customer.full_name_of_the_company_contact.gsub("'", "''")}', '#{customer.email_of_the_company_contact}', '#{get_total_ele(customer.id)}', '#{customer.address.city}')"
                    connection.exec(query)
                end
                puts "POPULATE DIM CUSTOMER: " + "\e[0;32mOK\e[0m"
            end
            task intervention: :environment do
                intervention_choices = Array['building', 'battery', 'column', 'elevator']
                result_choices = Array['Success', 'Failure', 'Incomplete']
                status_choices = Array['Pending', 'InProgress', 'Resumed']
                i = 0
                j = 250
                while i < j do
                    random_intervention = rand(0..3)
                    intervention = intervention_choices[random_intervention]
                    random_start_date = Faker::Date.between(from: 1095.days.ago, to: 200.days.ago)
                    random_end_date = Faker::Date.between(from: random_start_date, to: 200.days.ago)
                    random_date_time_start = Faker::Time.between_dates(from: random_start_date, to: random_end_date, period: :morning, format: :default)
                    random_date_time_end = Faker::Time.between_dates(from: random_end_date, to: random_end_date, period: :all, format: :default)
                    random_employee_id = rand(1..21)
                    random_result = rand(0..2)
                    result = result_choices[random_result]
                    random_status = rand(0..2)
                    randomStatus = status_choices[random_status]
                    if result == 'Success'
                        status = 'Complete'
                    elsif result == 'Failure'
                        status = 'Interrupted'
                    elsif result == 'Incomplete'
                        status = randomStatus
                    end
                    if intervention == 'building'
                        random_building_id = rand(1..178)
                        query = "insert into fact_interventions(employee_id, building_id, start_intervention, end_intervention, result, status) values('#{random_employee_id}', '#{random_building_id}', '#{random_date_time_start}', '#{random_date_time_end}', '#{result}', '#{status}')"
                        connection.exec(query)
                        
                    
                    elsif intervention == 'battery'
                        battery_count = Battery.all.count
                        random_battery_id = rand(1..battery_count)
                        battery = Battery.find(random_battery_id)
                        building_id = battery.building.id
                        query = "insert into fact_interventions(employee_id, building_id, battery_id, start_intervention, end_intervention, result, status) values('#{random_employee_id}', '#{building_id}', '#{random_battery_id}', '#{random_date_time_start}', '#{random_date_time_end}', '#{result}', '#{status}')"
                        connection.exec(query)
                        
                    elsif intervention == 'column'
                        column_count = Column.all.count
                        random_column_id = rand(1..column_count)
                        column = Column.find(random_column_id)
                        battery_id = column.battery.id
                        building_id = column.battery.building.id
                        query = "insert into fact_interventions(employee_id, building_id, battery_id, column_id, start_intervention, end_intervention, result, status) values('#{random_employee_id}', '#{building_id}', '#{battery_id}', '#{random_column_id}','#{random_date_time_start}', '#{random_date_time_end}', '#{result}', '#{status}')"
                        connection.exec(query)
                        
                    elsif intervention == 'elevator'
                        elevator_count = Battery.all.count
                        random_elevator_id = rand(1..elevator_count)
                        elevator = Elevator.find(random_elevator_id)
                        column_id = elevator.column.id
                        battery_id = elevator.column.battery.id
                        building_id = elevator.column.battery.building.id
                        query = "insert into fact_interventions(employee_id, building_id, battery_id, column_id, elevator_id,  start_intervention, end_intervention, result, status) values('#{random_employee_id}', '#{building_id}', '#{battery_id}', '#{column_id}', '#{random_elevator_id}','#{random_date_time_start}', '#{random_date_time_end}', '#{result}', '#{status}')"
                        connection.exec(query)
                    end
                    i += 1
                end
                puts "POPULATE FACT_INTERVENTIONS: " + "\e[0;32mOK\e[0m"
            end
        end
end



namespace :final do
    task setup: :environment do
        Rake::Task["db:reset"].invoke
        print "RESET AND INIT MYSQL DATABASE: "
        puts "\e[0;32mOK\e[0m"
        Rake::Task["wh:reset"].invoke
    end
end
