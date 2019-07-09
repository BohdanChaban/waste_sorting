require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:valid_account) do
    { name: 'Name',
      surname: 'Surname',
      address: 'Львів',
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

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: account.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: account.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Account' do
        expect do
        post :create, params: { account: valid_account }, session: valid_session
        end.to change(Account, :count).by(1)
      end

      it 'redirects to the created account' do
        post :create, params: { account: valid_account }, session: valid_session
        expect(response).to redirect_to(Account.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
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
        put :update, params: { id: account.to_param, account: valid_account }, session: valid_session
        account.reload
      end

      it 'redirects to the account' do
        put :update, params: { id: account.to_param, account: valid_account }, session: valid_session
        expect(response).to redirect_to(account)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: account.to_param, account: invalid_account }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested account' do
      expect do
        delete :destroy, params: { id: account.to_param }, session: valid_session
      end.to change(Account, :count).by(-1)
    end

    it 'redirects to the accounts list' do
      delete :destroy, params: { id: account.to_param }, session: valid_session
      expect(response).to redirect_to(accounts_url)
    end
  end
end
