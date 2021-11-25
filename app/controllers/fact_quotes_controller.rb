class FactQuotesController < ApplicationController
  before_action :set_fact_quote, only: %i[ show edit update destroy ]

  # GET /fact_quotes or /fact_quotes.json
  def index
    @fact_quotes = FactQuote.all
  end

  # GET /fact_quotes/1 or /fact_quotes/1.json
  def show
  end

  # GET /fact_quotes/new
  def new
    @fact_quote = FactQuote.new
  end

  # GET /fact_quotes/1/edit
  def edit
  end

  # POST /fact_quotes or /fact_quotes.json
  def create
    @fact_quote = FactQuote.new(fact_quote_params)

    respond_to do |format|
      if @fact_quote.save
        format.html { redirect_to @fact_quote, notice: "Fact quote was successfully created." }
        format.json { render :show, status: :created, location: @fact_quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fact_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fact_quotes/1 or /fact_quotes/1.json
  def update
    respond_to do |format|
      if @fact_quote.update(fact_quote_params)
        format.html { redirect_to @fact_quote, notice: "Fact quote was successfully updated." }
        format.json { render :show, status: :ok, location: @fact_quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fact_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fact_quotes/1 or /fact_quotes/1.json
  def destroy
    @fact_quote.destroy
    respond_to do |format|
      format.html { redirect_to fact_quotes_url, notice: "Fact quote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fact_quote
      @fact_quote = FactQuote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fact_quote_params
      params.fetch(:fact_quote, {})
    end
end
