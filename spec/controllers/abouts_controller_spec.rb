require 'rails_helper'

RSpec.describe AboutsController, type: :controller do
  let(:user_admin) { FactoryBot.create(:user_admin) }
  let(:user_customer) { FactoryBot.create(:user_customer) }

  let(:about) { FactoryBot.create(:about) }
  let(:about_invalid) do
    { content: '' }
  end
  let(:about_valid) do
    { content: 'fffff' }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    context 'sign_in with admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :edit, params: { id: about.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with customer role' do
      it 'returns a not success response' do
        login_with user_customer
        get :edit, params: { id: about.to_param }, session: valid_session
        expect(response).not_to be_successful
      end
    end
    context 'without sign_in' do
      it 'returns a not success response' do
        get :edit, params: { id: about.to_param }, session: valid_session
        expect(response).not_to be_successful
      end
    end
  end

  describe 'PUT #update' do
    let(:about_updated) do
      { context: 'ttttttt' }
    end
    context 'sign_in with admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :update, params: { id: about.to_param, about: about_updated }, session: valid_session
        about.reload
      end

      it 'redirects to the abouts' do
        login_with user_admin
        put :update, params: { id: about.to_param, about: about_valid }, session: valid_session
        expect(response).to redirect_to(abouts_path)
      end
      it 'returns a not success response' do
        login_with user_admin
        get :update, params: { id: about.to_param, about: about_invalid }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'without sign_in' do
      it 'returns a not success response' do
        get :update, params: { id: about.to_param }, session: valid_session
        expect(response).not_to be_successful
      end
    end
  end
end
