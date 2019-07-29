class InquiriesController < ApplicationController
  before_action :check_customer_access, only: %i[new create]
  before_action :check_full_access, only: %i[update edit destroy]
  before_action :set_inquiry, only: %i[show edit update destroy]

  def index
    @inquiries = InquiryService.new(current_user).call
  end

  def show; end

  def new; end

  def edit; end

  def create
    new_inquiry
    respond_to do |format|
      if @inquiry.save
        format.html { redirect_to @inquiry, notice: 'Inquiry was successfully created.' }
        format.json { render :show, status: :created, location: @inquiry }
      else
        format.html { redirect_to timeslots_url, notice: 'Inquiry was unsuccessfully created.' }
        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @inquiry.user = current_user
    respond_to do |format|
      if @inquiry.update(inquiry_params)
        format.html { redirect_to timeslots_url, notice: 'Inquiry was successfully updated.' }
        format.json { render :show, status: :ok, location: @inquiry }
      else
        format.html { render :edit }
        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inquiry.destroy
    respond_to do |format|
      format.html { redirect_to inquiries_url, notice: 'Inquiry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def inquiry_params
    params.require(:inquiry).permit(:status, :timeslot_id, :user_id)
  end

  def new_inquiry
    @timeslot = Timeslot.find(params[:timeslot_id])
    @inquiry = @timeslot.inquiries.build
    @inquiry.user = current_user
  end
end
