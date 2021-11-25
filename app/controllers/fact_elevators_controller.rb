class FactElevatorsController < ApplicationController
  before_action :set_fact_elevator, only: %i[ show edit update destroy ]

  # GET /fact_elevators or /fact_elevators.json
  def index
    @fact_elevators = FactElevator.all
  end

  # GET /fact_elevators/1 or /fact_elevators/1.json
  def show
  end

  # GET /fact_elevators/new
  def new
    @fact_elevator = FactElevator.new
  end

  # GET /fact_elevators/1/edit
  def edit
  end

  # POST /fact_elevators or /fact_elevators.json
  def create
    @fact_elevator = FactElevator.new(fact_elevator_params)

    respond_to do |format|
      if @fact_elevator.save
        format.html { redirect_to @fact_elevator, notice: "Fact elevator was successfully created." }
        format.json { render :show, status: :created, location: @fact_elevator }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fact_elevator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fact_elevators/1 or /fact_elevators/1.json
  def update
    respond_to do |format|
      if @fact_elevator.update(fact_elevator_params)
        format.html { redirect_to @fact_elevator, notice: "Fact elevator was successfully updated." }
        format.json { render :show, status: :ok, location: @fact_elevator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fact_elevator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fact_elevators/1 or /fact_elevators/1.json
  def destroy
    @fact_elevator.destroy
    respond_to do |format|
      format.html { redirect_to fact_elevators_url, notice: "Fact elevator was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fact_elevator
      @fact_elevator = FactElevator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fact_elevator_params
      params.fetch(:fact_elevator, {})
    end
end
