class InterventionsController < InheritedResources::Base
  before_action :authenticate_employee_user!

  def new
    @intervention = Intervention.new
  end

  def submit
    @cur_employee = current_user.employees[0]
    @intervention = Intervention.new(
      author: @cur_employee.id,
      customer_id: params[:intervention][:customer_id],
      building_id: params[:intervention][:building_id],
      battery_id: params[:intervention][:battery_id],
      column_id: params[:intervention][:column_id],
      elevator_id: params[:intervention][:elevator_id],
      employee_id: params[:intervention][:employee_id],
      report: params[:intervention][:report],
    )

    respond_to do |format|
      if @intervention.save
        format.html { redirect_to "/", notice: "intervention was successfully created" }
        puts "intervention saved"
      else
        format.html { redirect_to "/", notice: "intervention was not created" }
        puts "intervention failed to save"
      end
    end

    # if @intervention.save
    #   flash[:notice] = "add new intervention successfull "
    #   redirect_to :index
    # else
    #   flash[:notice] = "add new intervention not successfull "
    #   raise StandardError, @intervention.errors.messages
    #   redirect_to action:"new"
    # end
    @customer = Customer.find(@intervention.customer_id)
    @employee = Employee.find(@intervention.employee_id)

    ZendeskAPI::Ticket.create!(@client,
                               :subject => "Intervention for #{@customer.company_name}",
                               :requester => {
                                 "name": "#{@cur_employee.first_name} #{@cur_employee.last_name}",
                                 "email": "#{@cur_employee.email}",
                               },
                               :comment => {
                                 :value => "There is an intervention. \n\n
          Customer: #{@customer.company_name}\n 
          Building ID: #{@intervention.building_id}\n 
          Battery ID: #{@intervention.battery_id}\n
          Column ID: #{@intervention.column_id}\n
          Elevator ID: #{@intervention.elevator_id}\n
          Employee: #{@employee.first_name} #{@employee.last_name}\n
          Description: #{@intervention.report}\n",
                               },
                               :type => "problem",
                               :priority => "urgent")
  end

  def get_buildings
    @buildings = Building.where(customer_id: params[:customer_id])
    puts params[:customer_id]

    render json: { buildings: @buildings }

    # respond_to do |format|
    #   format.json {render :json => @buildings}
    # end
  end

  def get_batteries
    @batteries = Battery.where(building_id: params[:building_id])

    render json: { batteries: @batteries }

    # respond_to do |format|
    #   format.json {render :json => @batteries}
    # end
  end

  def get_columns
    @columns = Column.where(battery_id: params[:battery_id])

    render json: { columns: @columns }

    # respond_to do |format|
    #   format.json {render :json => @columns}
    # end
  end

  def get_elevators
    @elevators = Elevator.where(column_id: params[:column_id])

    render json: { elevators: @elevators }

    # respond_to do |format|
    #   format.json {render :json => @elevators}
    # end
  end

  private

  def intervention_params
    param.permit(:author, :customer_id, :building_id, :battery_id, :column_id, :elevator_id, :employee_id, :start_intervention, :end_intervention, :result, :report, :status, :intervention)
  end
end
