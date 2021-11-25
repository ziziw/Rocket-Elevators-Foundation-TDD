class FactContactsController < ApplicationController
  before_action :set_fact_contact, only: %i[ show edit update destroy ]

  # GET /fact_contacts or /fact_contacts.json
  def index
    @fact_contacts = FactContact.all
  end

  # GET /fact_contacts/1 or /fact_contacts/1.json
  def show
  end

  # GET /fact_contacts/new
  def new
    @fact_contact = FactContact.new
  end

  # GET /fact_contacts/1/edit
  def edit
  end

  # POST /fact_contacts or /fact_contacts.json
  def create
    @fact_contact = FactContact.new(fact_contact_params)

    respond_to do |format|
      if @fact_contact.save
        format.html { redirect_to @fact_contact, notice: "Fact contact was successfully created." }
        format.json { render :show, status: :created, location: @fact_contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fact_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fact_contacts/1 or /fact_contacts/1.json
  def update
    respond_to do |format|
      if @fact_contact.update(fact_contact_params)
        format.html { redirect_to @fact_contact, notice: "Fact contact was successfully updated." }
        format.json { render :show, status: :ok, location: @fact_contact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fact_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fact_contacts/1 or /fact_contacts/1.json
  def destroy
    @fact_contact.destroy
    respond_to do |format|
      format.html { redirect_to fact_contacts_url, notice: "Fact contact was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fact_contact
      @fact_contact = FactContact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fact_contact_params
      params.fetch(:fact_contact, {})
    end
end
