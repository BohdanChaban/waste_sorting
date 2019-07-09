require 'rails_helper'

RSpec.describe CitiesController, type: :controller do
  let(:city) { FactoryBot.create(:city_with_valid_name) }

  let(:valid_session) { {} }

  let(:user) { FactoryBot.create(:user) }

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
      get :show, params: { id: city.to_param }, session: valid_session
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

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new City' do
        login_with user
        expect do
          post :create, params: { city: { name: 'Бібрка' } }, session: valid_session
        end.to change(City, :count).by(1)
      end

      it 'redirects to the created city' do
        login_with user
        post :create, params: { city: { name: 'Болехів' } }, session: valid_session
        expect(response).to redirect_to(City.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        login_with user
        post :create, params: { city: { name: nil } }, session: valid_session
        expect(response).to be_successful
      end
    end
  end
end
