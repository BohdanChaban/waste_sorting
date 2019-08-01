require 'rails_helper'

RSpec.describe RegistrationsController, regall: true, type: :controller do
  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end
  let(:valid_session) { {} }
  let(:user_manager) { FactoryBot.create(:user_manager) }
  let(:user_customer) { FactoryBot.create(:user_customer) }
  let(:user_admin) { FactoryBot.create(:user_admin) }
  let!(:account) { FactoryBot.build(:account_with_manager_role) }

  let(:user_new) do
    {
      email: 'jmanager@gmail.com',
      password: '12345678',
      password_confirmation: '12345678'
    }
  end
  describe 'GET #edit' do
    context 'sign_in with admin role' do
      it 'returns a success response' do
        account.save!
        login_with user_admin
        get :edit, params: { id: account.user.id.to_param }
        expect(response).to be_successful
      end
    end
    context 'sign_in with customer role' do
      it 'returns a success response' do
        login_with user_customer
        get :edit, params: {}
        expect(response).to be_successful
      end
    end
    context 'sign_in with manager role' do
      it 'returns a success response' do
        login_with user_manager
        get :edit, params: {}
        expect(response).to be_successful
      end
    end
    context 'not sign_in user' do
      it 'not returns a success response' do
        get :edit, params: {}
        expect(response).not_to be_successful
      end
    end
  end

  describe 'POST #create' do
    context 'sign_in with admin role create user_manager with valid params' do
      it 'redirects to the created account' do
        login_with user_admin
        post :create, params: { user: user_new }, session: valid_session
        expect(response).to redirect_to(accounts_path(role: 'manager'))
      end
    end
    context 'sign_in with customer role create user_manager with valid params' do
      it 'not redirects to the created account' do
        login_with user_customer
        post :create, params: { user: user_new }, session: valid_session
        expect(response).to redirect_to(root_path)
      end
    end
    context 'sign_in with manager role create user_manager with valid params' do
      it 'not redirects to the created account' do
        login_with user_manager
        post :create, params: { user: user_new }, session: valid_session
        expect(response).to redirect_to(root_path)
      end
    end
    context 'not_sign_in create new user with valid params' do
      it 'redirects to the created account' do
        post :create, params: { user: user_new }, session: valid_session
        expect(response).to redirect_to(new_account_path)
      end
    end
  end

  describe 'PUT #update' do
    let(:password_updated) do
      {
        password: 'qwerty',
        password_confirmation: 'qwerty'
      }
    end
    let(:invalid_password) do
      {
        password: '',
        password_confirmation: ''
      }
    end
    context 'sign_in with admin role update user_manager ' do
      it 'updates the requested account with valid params' do
        account.save!
        login_with user_admin
        put :update, params: { id: account.user.id.to_param, user: password_updated }, session: valid_session
        account.user.reload
        expect(response).to redirect_to(accounts_path(role: 'manager'))
      end
      it 'not updates the requested account with invalid params' do
        account.save!
        login_with user_admin
        put :update, params: { id: account.user.id.to_param, user: invalid_password }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with customer role update user_manager' do
      it 'updates the requested account with valid params' do
        account.save!
        login_with user_customer
        put :update, params: { id: account.user.id.to_param, user: password_updated }, session: valid_session
        account.user.reload
        expect(response).to be_successful
      end
      it 'not updates the requested account with invalid params' do
        account.save!
        login_with user_customer
        put :update, params: { id: account.user.id.to_param, user: invalid_password }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'not_sign_in update user_manager with valid params' do
      it 'updates the requested account' do
        account.save!
        put :update, params: { id: account.user.id.to_param, user: password_updated }, session: valid_session
        expect(response).not_to be_successful
      end
    end
  end
end
