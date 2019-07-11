require 'rails_helper'

RSpec.describe DistrictsController, type: :controller do
  let(:valid_session) { {} }
  let(:district_with_valid_name) do
    { name: 'Личаківський', city_id: district.city_id }
  end

  let(:district_with_invalid_name) do
    { name: '' }
  end

  let(:user_admin) { FactoryBot.create(:user_admin) }

  let!(:district) { FactoryBot.create(:district_with_valid_name) }

  describe 'GET #new' do
    it 'returns a success response' do
      login_with user_admin
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      login_with user_admin
      get :edit, params: { id: district.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new District' do
        login_with user_admin
        expect do
          post :create, params: { district: district_with_valid_name }, session: valid_session
        end.to change(District, :count).by(1)
      end

      it 'redirects to the cities list' do
        login_with user_admin
        post :create, params: { district: district_with_valid_name }, session: valid_session
        expect(response).to redirect_to(cities_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        login_with user_admin
        post :create, params: { district: district_with_invalid_name }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:district_updated) do
        { name: 'Личаківський' }
      end

      it 'updates the requested district' do
        login_with user_admin
        put :update, params: { id: district.to_param, district: district_updated }, session: valid_session
        district.reload
      end

      it 'redirects to the district' do
        login_with user_admin
        put :update, params: { id: district.to_param, district: district_with_valid_name }, session: valid_session
        expect(response).to redirect_to(district)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        login_with user_admin
        put :update, params: { id: district.to_param, district: district_with_invalid_name }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested district' do
      login_with user_admin
      expect do
        delete :destroy, params: { id: district.to_param }, session: valid_session
      end.to change(District, :count).by(-1)
    end

    it 'redirects to the districts list' do
      login_with user_admin
      delete :destroy, params: { id: district.to_param }, session: valid_session
      expect(response).to redirect_to(districts_url)
    end
  end
end