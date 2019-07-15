require 'rails_helper'

RSpec.describe DistrictsController, type: :controller do
  let(:valid) { {} }
  let(:district_valid_name) do
    { name: 'Личаківський', city_id: district.city_id }
  end

  let(:district_invalid_name) do
    { name: '' }
  end
  let!(:id) { district.city_id }

  let(:user_customer) { FactoryBot.create(:user_customer) }

  let(:user_admin) { FactoryBot.create(:user_admin) }

  let!(:district) { FactoryBot.create(:district_valid_name) }

  describe 'GET #new' do
    context 'sign_in with admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :new, params: { city_id: id }, session: valid
        expect(response).to be_successful
      end
    end
    context 'sign_in with customer role' do
      it 'returns a not success response' do
        login_with user_customer
        get :new, params: { city_id: id }, session: valid
        expect(response).not_to be_successful
      end
    end
  end
  describe 'GET #edit' do
    context 'sign_in with admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :edit, params: { city_id: id, id: district.to_param }, session: valid
        expect(response).to be_successful
      end
    end
    context 'sign_in with customer role' do
      it 'returns a not success response' do
        login_with user_customer
        get :edit, params: { city_id: id, id: district.to_param }, session: valid
        expect(response).not_to be_successful
      end
    end
  end

  describe 'POST #create' do
    context 'sign_in with admin role' do
      context 'with valid params' do
        it 'creates a new District' do
          login_with user_admin
          expect do
            post :create, params: { city_id: id, district: district_valid_name }, session: valid
          end.to change(District, :count).by(1)
        end

        it 'redirects to the cities list' do
          login_with user_admin
          post :create, params: { city_id: id, district: district_valid_name }, session: valid
          expect(response).to redirect_to(city_path(district.city_id))
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          login_with user_admin
          post :create, params: { city_id: id, district: district_invalid_name }, session: valid
          expect(response).to be_successful
        end
      end
    end

    context 'sign_in with customer role' do
      context 'with valid params' do
        it 'not creates a new District' do
          login_with user_customer
          expect do
            post :create, params: { city_id: id, district: district_valid_name }, session: valid
          end.to change(District, :count).by(0)
        end

        it 'redirects to the root_path' do
          login_with user_customer
          post :create, params: { city_id: id, district: district_valid_name }, session: valid
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid params' do
        it 'returns a not success response' do
          login_with user_customer
          post :create, params: { city_id: id, district: district_invalid_name }, session: valid
          expect(response).not_to be_successful
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'sign_in with admin role' do
      context 'with valid params' do
        let(:district_updated) do
          { name: 'Личаківський' }
        end

        it 'updates the requested district' do
          login_with user_admin
          put :update, params: { city_id: id, id: district.to_param, district: district_updated }, session: valid
          district.reload
        end

        it 'redirects to the district' do
          login_with user_admin
          put :update, params: { city_id: id, id: district.to_param, district: district_valid_name }, session: valid
          expect(response).to redirect_to(city_path(district.city_id))
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          login_with user_admin
          put :update, params: { city_id: id, id: district.to_param, district: district_invalid_name }, session: valid
          expect(response).to be_successful
        end
      end
    end
    context 'sign_in with customer role' do
      context 'with valid params' do
        let(:district_updated) do
          { name: 'Личаківський' }
        end

        it 'not updates the requested district' do
          login_with user_customer
          put :update, params: { city_id: id, id: district.to_param, district: district_updated }, session: valid
          district.reload
        end

        it 'redirects to the district' do
          login_with user_customer
          put :update, params: { city_id: id, id: district.to_param, district: district_valid_name }, session: valid
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          login_with user_customer
          put :update, params: { city_id: id, id: district.to_param, district: district_invalid_name }, session: valid
          expect(response).not_to be_successful
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'sign_in with admin role' do
      it 'destroys the requested district' do
        login_with user_admin
        expect do
          delete :destroy, params: { city_id: id, id: district.to_param }, session: valid
        end.to change(District, :count).by(-1)
      end

      it 'redirects to the districts list' do
        login_with user_admin
        delete :destroy, params: { city_id: id, id: district.to_param }, session: valid
        expect(response).to redirect_to(city_path(district.city_id))
      end
    end

    context 'sign_in with customer role' do
      it 'not destroys the requested district' do
        login_with user_customer
        expect do
          delete :destroy, params: { city_id: id, id: district.to_param }, session: valid
        end.to change(District, :count).by(0)
      end

      it 'redirects to the root path' do
        login_with user_customer
        delete :destroy, params: { city_id: id, id: district.to_param }, session: valid
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
