class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update]
  before_action :check_admin_access, only: %i[index]
  def index
    @accounts = Account.all
  end

  def show; end

  def new
    redirect_to account_path(current_user.account) unless current_user.account.nil?
    @account = Account.new
    @cities = City.all
  end

  def edit
    @cities = City.all
  end

  def create
    new_account
    respond_to do |format|
      if @account.save
        format.html { redirect_to current_account_path, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_account
    @account = current_user.account
  end

  def account_params
    params.require(:account).permit(:name, :surname, :address, :mobile_number, :city_id)
  end

  def new_account
    @account = Account.new(account_params)
    @account.user = current_user
  end

  def current_account_path
    account_path(current_user.account)
  end
end
