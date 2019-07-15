class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def check_admin_access
    redirect_to root_path unless current_user&.admin?
  end
end
