require 'rails_helper'

RSpec.describe RequestsController, type: :controller do
  let(:valid_session) { {} }

  let(:request_valid_status) do
    { status: 'initiated' }
  end

  let(:request_invalid_status) do
    status { ' ' }
  end
  let(:user_customer) { FactoryBot.create(:user_customer) }
  let(:user_manager) { FactoryBot.create(:user_manager) }
  let(:user_admin) { FactoryBot.create(:user_admin) }
  let(:timeslot) { FactoryBot.create(:timeslot_valid_time) }
  let(:request) { FactoryBot.create(:request_valid_status) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: request.to_param }, session: valid_session
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
      get :edit, params: { id: request.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Request' do
        expect do
          post :create, params: { request: request_valid_status }, session: valid_session
        end.to change(Request, :count).by(1)
      end

      it 'redirects to the created request' do
        post :create, params: { request: request_valid_status }, session: valid_session
        expect(response).to redirect_to(Request.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { request: request_valid_status }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested request' do
        put :update, params: { id: request.to_param, request: request_valid_status }, session: valid_session
        request.reload
      end

      it 'redirects to the request' do
        put :update, params: { id: request.to_param, request: request_valid_status }, session: valid_session
        expect(response).to redirect_to(request)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: request.to_param, request: request_valid_status }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested request' do
      expect do
        delete :destroy, params: { id: request.to_param }, session: valid_session
      end.to change(Request, :count).by(-1)
    end

    it 'redirects to the requests list' do
      delete :destroy, params: { id: request.to_param }, session: valid_session
      expect(response).to redirect_to(requests_url)
    end
  end
end
