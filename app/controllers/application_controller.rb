class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(_resource)
    current_user.account ? root_path : new_account_path
  end
end
