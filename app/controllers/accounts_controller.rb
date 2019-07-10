class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update]

  def index
    @accounts = Account.all
  end

  def show; end

  def new
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
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
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
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :surname, :address, :mobile_number, :city_id)
  end

  def new_account
    @account = Account.new(account_params)
    @account.user = current_user
  end
end
