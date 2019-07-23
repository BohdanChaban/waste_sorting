require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:valid_account) do
    { name: 'Name',
      surname: 'Surname',
      address: 'Шевченка, 77',
      mobile_number: '+380998765952',
      city_id: account.city_id ,
      district_id: account.district_id
    }
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
    it 'returns a success response' do
      login_with user
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      login_with user
      get :show, params: { id: account.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      login_with user
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      login_with user
      get :edit, params: { id: account.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Account' do
        login_with user
        expect do
          post :create, params: { account: valid_account }, session: valid_session
        end.to change(Account, :count).by(1)
      end

      it 'redirects to the created account' do
        login_with user
        post :create, params: { account: valid_account }, session: valid_session
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        login_with user
        post :create, params: { account: invalid_account }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

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
