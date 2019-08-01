class InquiriesController < ApplicationController
  before_action :check_customer_access, only: %i[create]
  before_action :check_full_access, only: %i[update destroy]
  before_action :set_inquiry, only: %i[show update destroy]

  def index
    inquiries = InquiryService.new(current_user).call
    @initiated = inquiries.select { |i| i.status == 'initiated' }
    @approved = inquiries.select { |i| i.status == 'approved' }
    @completed = inquiries.select { |i| i.status == 'completed' }
  end

  def show; end

  def create
    new_inquiry
    respond_to do |format|
      if @inquiry.save
        format.html { redirect_to @inquiry, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @inquiry }
      else
        format.html { redirect_to timeslots_url, notice: 'Requests was not created.' }
        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @inquiry.update(inquiry_params)
        format.html { redirect_to inquiries_url, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @inquiry }
      else
        format.html { redirect_to inquiries_url, notice: 'Requests was not updated..' }
        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inquiry.destroy
    respond_to do |format|
      format.html { redirect_to inquiries_url, notice: 'Request was successfully destroyed.' }
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
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.user = current_user
  end
end
