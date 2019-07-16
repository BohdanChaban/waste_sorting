class AboutsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_admin_access, only: %i[edit update]
  before_action :set_about, only: %i[edit update]

  def index
    @abouts = About.all
  end

  def edit; end

  def update
    respond_to do |format|
      if @about.update(about_params)
        format.html { redirect_to abouts_path, notice: 'About was successfully updated.' }
        format.json { render :show, status: :ok, location: @about }
      else
        format.html { render :edit }
        format.json { render json: @about.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_about
    @about = About.find(params[:id])
  end

  def about_params
    params.require(:about).permit(:content)
  end
end
