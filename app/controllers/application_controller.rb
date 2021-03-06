class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(_resource)
    current_user.account ? root_path : new_account_path
  end

  private

  def check_admin_access
    redirect_to root_path unless current_user&.admin?
  end

  def check_customer_access
    redirect_to root_path unless current_user&.customer?
  end

  def check_full_access
    redirect_to root_path unless current_user&.manager? || current_user&.admin?
  end
end
