require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:valid_account) do
    { name: 'Name',
      surname: 'Surname',
      address: 'Шевченка, 77',
      mobile_number: '+380998765952' }
  end

  let(:invalid_account) do
    { name: ' ',
      surname: ' ',
      address: ' ',
      mobile_number: '+38099' }
  end

  let(:account) { FactoryBot.create(:account) }

  let(:valid_session) { {} }

  let(:user) { account.user }

  describe 'GET #index' do
    it 'returns a success response for admin' do
      user.role = 'admin'
      login_with user
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end

    it 'returns a not_success response for other users' do
      login_with user
      get :index, params: {}, session: valid_session
      expect(response).not_to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      login_with user
      get :show, params: { id: account.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new', tdd: true do
    context 'new account' do
      let(:user_customer) { FactoryBot.create(:user_customer) }
      let(:account) { nil }

      it 'when account not exist' do
        login_with user_customer
        get :new, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'redirect to show page' do
      it 'when accounts already exist' do
        login_with user
        get :new, params: {}, session: valid_session
        expect(response).to redirect_to(account_path(user.account))
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      login_with user
      get :edit, params: { id: account.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create', tdd1: true do
    let(:user_customer) { FactoryBot.create(:user_customer) }
    let(:valid_account_with_district) do
      { name: 'TestName',
        surname: 'Surname',
        address: 'Шевченка, 77',
        mobile_number: '+380998765952',
        district_id: district.id }
    end

    let(:district) { FactoryBot.create(:district_valid_name) }
    context 'create account with valid params' do
      it 'when account not exist' do
        login_with user_customer
        expect do
          post :create, params: { account: valid_account_with_district }, session: valid_session
        end.to change(Account, :count).by(1)
      end

      it 'redirects to the created account' do
        login_with user_customer
        post :create, params: { account: valid_account_with_district }, session: valid_session
        expect(response).to redirect_to(account_path(user_customer.account))
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        login_with user_customer
        post :create, params: { account: invalid_account }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested account' do
        login_with user
        put :update, params: { id: account.to_param, account: valid_account }, session: valid_session
        account.reload
      end

      it 'redirects to the account' do
        login_with user
        put :update, params: { id: account.to_param, account: valid_account }, session: valid_session
        expect(response).to redirect_to(account)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        login_with user
        put :update, params: { id: account.to_param, account: invalid_account }, session: valid_session
        expect(response).to be_successful
      end
    end
  end
end
