class RequestsController < ApplicationController
  before_action :check_customer_access, only: %i[new create]
  before_action :check_full_access, only: %i[update edit destroy]
  before_action :set_request, only: %i[show edit update destroy]

  def index
    @requests = RequestService.new(current_user).call
  end

  def show; end

  def new
    @request = Request.new
  end

  def edit; end

  def create
    new_request
    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @request.user = current_user
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def new_request
    @request = Request.new(request_params)
    @request.user = current_user
  end

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:status, :user_id, :timeslot_id)
  end
end
