class RegistrationsController < Devise::RegistrationsController
  def create
    if current_user
      @user = User.new(sign_up_params)
      @user.save ? (redirect_to root_path, notice: 'User succesfully created!') : (render :new)
    else
      super
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update_attributes(user_params)
  #     redirect_to user_url, notice: 'Updated User.'
  #   else
  #     render :edit
  #   end
  # end

  protected

  before_action :authorize_user!, only: %i[new create]
  skip_before_action :require_no_authentication, only: %i[new create]

  def authorize_user!
    redirect_to '/', notice: 'Your permissions do not allow access to this page' unless current_user.admin?
  end

  def after_sign_up_path_for(_resource)
    new_account_path
  end
end
