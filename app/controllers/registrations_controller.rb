class RegistrationsController < Devise::RegistrationsController
  before_action :authorize_user!, only: %i[new create]
  skip_before_action :require_no_authentication, only: %i[new create]

  def create
    if current_user
      @user = User.new(sign_up_params)
      @user.role = 'manager'
      @user.save ? (redirect_to accounts_path(role: 'manager'), notice: 'User succesfully created!') : (render :new)
    else
      super
    end
  end

  def edit
    if current_user.admin?
      set_user
      redirect_to root_path unless user_role_check
    else
      super
    end
  end

  def update
    if current_user.admin?
      user_role_check
      if @user.update_attributes(account_update_params)
        redirect_to accounts_path(role: 'manager'), notice: 'Updated User.'
      else
        render :edit
      end
    else
      super
    end
  end

  protected

  def set_user
    @user = User.find(params[:id])
  end

  def user_role_check
    set_user
    @user if @user.role == 'manager'
  end

  def authorize_user!
    redirect_to '/', notice: 'Not allow access to this page' unless current_user.nil? || current_user.admin?
  end

  def after_sign_up_path_for(_resource)
    new_account_path
  end
end
