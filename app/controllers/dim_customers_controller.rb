class DimCustomersController < ApplicationController
  before_action :set_dim_customer, only: %i[ show edit update destroy ]

  # GET /dim_customers or /dim_customers.json
  def index
    @dim_customers = DimCustomer.all
  end

  # GET /dim_customers/1 or /dim_customers/1.json
  def show
  end

  # GET /dim_customers/new
  def new
    @dim_customer = DimCustomer.new
  end

  # GET /dim_customers/1/edit
  def edit
  end

  # POST /dim_customers or /dim_customers.json
  def create
    @dim_customer = DimCustomer.new(dim_customer_params)

    respond_to do |format|
      if @dim_customer.save
        format.html { redirect_to @dim_customer, notice: "Dim customer was successfully created." }
        format.json { render :show, status: :created, location: @dim_customer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dim_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dim_customers/1 or /dim_customers/1.json
  def update
    respond_to do |format|
      if @dim_customer.update(dim_customer_params)
        format.html { redirect_to @dim_customer, notice: "Dim customer was successfully updated." }
        format.json { render :show, status: :ok, location: @dim_customer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dim_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dim_customers/1 or /dim_customers/1.json
  def destroy
    @dim_customer.destroy
    respond_to do |format|
      format.html { redirect_to dim_customers_url, notice: "Dim customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dim_customer
      @dim_customer = DimCustomer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dim_customer_params
      params.fetch(:dim_customer, {})
    end
end
