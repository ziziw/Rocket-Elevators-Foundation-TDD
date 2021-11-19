# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy]
  protect_from_forgery except: :home
  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1 or /quotes/1.json
  def show; end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit; end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)
    unless verify_recaptcha?(params[:recaptcha_token], 'quote')
      flash.now[:error] = t('recaptcha.errors.verification_failed')
      return render 'home/index'
    end

    respond_to do |format|
      if @quote.save
        format.html { redirect_to root_path, notice: 'Quote was successfully created.' }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
    if @quote.product_line == "standard"
      elevator_price = 7565.00
    elsif @quote.product_line == "premium"
      elevator_price = 12345.00
    else
      elevator_price = 15400.00
    end

    ZendeskAPI::Ticket.create!(@client, 
      :subject => "#{@quote.company_name}",
      :requester => {"name": @quote.email},
      :comment => { :value => 
        "The company #{@quote.company_name} has made a quote for a building of type #{@quote.building_type} and wants the type of service #{@quote.product_line} service. Amount of elevators is #{@quote.amount_elevators}. Price per elevator: $#{elevator_price}. Installation fee is #{@quote.installation_fees}. Total price is #{@quote.total_cost}. The company #{@quote.company_name} can be contacted at #{@quote.email}"},
      :type => "task",  
      :priority => "urgent")
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to root_path, notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_quote
    @quote = Quote.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def quote_params
    params.permit(:building_type, :amount_elevators, :product_line, :installation_fees, :total_cost,
                  :amount_floors, :amount_basements, :amount_parking_spots, :maximum_occupancy, :amount_apartments,
                  :amount_companies, :amount_corporations, :business_hours, :email, :company_name, :full_name)
  end
end
