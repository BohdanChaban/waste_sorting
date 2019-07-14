class DistrictsController < ApplicationController
  before_action :check_admin_access
  before_action :set_district, only: %i[edit update destroy]

  def new
    @district = District.new
    @cities = City.all
  end

  # GET /districts/1/edit
  def edit
    @districts = District.all
    @cities = City.all
  end

  # POST /districts
  # POST /districts.json
  def create
    @district = District.new(district_params)
    respond_to do |format|
      if @district.save
        format.html { redirect_to cities_path, notice: 'District was successfully created.' }
        format.json { render :show, status: :created, location: @district }
      else
        format.html { render :new }
        format.json { render json: @district.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /districts/1
  # PATCH/PUT /districts/1.json
  def update
    respond_to do |format|
      if @district.update(district_params)
        format.html { redirect_to city_path(@district.city_id), notice: 'District was successfully updated.' }
        format.json { render :show, status: :ok, location: @district }
      else
        format.html { render :edit }
        format.json { render json: @district.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /districts/1
  # DELETE /districts/1.json
  def destroy
    @district.destroy
    respond_to do |format|
      format.html { redirect_to city_path(@district.city_id), notice: 'District was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_district
    @district = District.find(params[:id])
  end

  def district_params
    params.require(:district).permit(:name, :city_id)
  end
end
