class TimeslotsController < ApplicationController
  before_action :check_manager_access, except: %i[index show]
  before_action :set_timeslot, only: %i[show edit update destroy]

  def index
    if current_user.role == 'manager'
      @timeslots = current_user.timeslots
    elsif current_user.role == 'customer'
      @timeslots = Timeslot.select { |t| t.district.city == current_user.account.city }
    elsif current_user.role == 'admin'
      @timeslots = Timeslot.all
    end
  end

  def show
    @timeslot = Timeslot.find(params[:id])
  end

  def new
    @timeslot = Timeslot.new
  end

  def edit; end

  def create
    if (current_user&.admin?) || (current_user&.manager?)
      @timeslot = Timeslot.new(timeslot_params)
      @timeslot.user = current_user
      @timeslot.district = District.last
      respond_to do |format|
        if @timeslot.save
          format.html { redirect_to @timeslot, notice: 'Timeslot was successfully created.' }
          format.json { render :show, status: :created, location: @timeslot }
        else
          format.html { render :new }
          format.json { render json: @timeslot.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @timeslot.update(timeslot_params)
        format.html { redirect_to @timeslot, notice: 'Timeslot was successfully updated.' }
        format.json { render :show, status: :ok, location: @timeslot }
      else
        format.html { render :edit }
        format.json { render json: @timeslot.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @timeslot.destroy
    respond_to do |format|
      format.html { redirect_to timeslots_url, notice: 'Timeslot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_timeslot
    @timeslot = Timeslot.find(params[:id])
  end

  def timeslot_params
    params.require(:timeslot).permit(:start_time, :user, :district_id)
  end
end
