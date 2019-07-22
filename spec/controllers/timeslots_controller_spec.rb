require 'rails_helper'

RSpec.describe TimeslotsController, type: :controller do
  let(:valid_session) { {} }
  let(:timeslot_valid_time) do
    { start_time: Time.new(2019, 0o2, 24, 12, 0, 0, '+09:00'), district_id: district.id }
  end
  let(:valid_time_update) do
    { start_time: Time.new(2019, 0o2, 24, 12, 0, 0, '+09:00') }
  end
  let(:timeslot_invalid_time) do
    { start_time: ' ' }
  end
  let(:district_valid_name) do
    { name: 'Львівський', city_id: district.city_id }
  end
  let(:user_customer) { FactoryBot.create(:user_customer) }
  let(:user_manager) { FactoryBot.create(:user_manager) }
  let(:user_admin) { FactoryBot.create(:user_admin) }
  let(:district) { FactoryBot.create(:district_valid_name) }
  let(:timeslot) { FactoryBot.create(:timeslot_valid_time) }

  describe 'GET #index' do
    context 'sign_in with user_customer role' do
      it 'returns a success response' do
        login_with user_customer
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with user_manager role' do
      it 'returns a success response' do
        login_with user_manager
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with user_admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #show' do
    context 'sign_in with user_customer role' do
      it 'returns a success response' do
        login_with user_customer
        get :show, params: { id: timeslot.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with user_manager role' do
      it 'returns a success response' do
        login_with user_manager
        get :show, params: { id: timeslot.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with user_admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :show, params: { id: timeslot.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #new' do
    context 'sign_in with user_customer role' do
      it 'returns a success response' do
        login_with user_customer
        get :new, params: {}, session: valid_session
        expect(response).not_to be_successful
      end
    end
    context 'sign_in with user_manager role' do
      it 'returns a success response' do
        login_with user_manager
        get :new, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with user_admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :new, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #edit' do
    context 'sign_in with user_customer role' do
      it 'returns a success response' do
        login_with user_customer
        get :edit, params: { id: timeslot.to_param }, session: valid_session
        expect(response).not_to be_successful
      end
    end
    context 'sign_in with user_manager role' do
      it 'returns a success response' do
        login_with user_manager
        get :edit, params: { id: timeslot.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with user_admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :edit, params: { id: timeslot.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #create' do
    context 'sign_in with user_customer role' do
      context 'with valid params' do
        it 'creates a new Timeslot' do
          login_with user_customer
          expect do
            post :create, params: { timeslot: timeslot_valid_time }, session: valid_session
          end.to change(Timeslot, :count).by(0)
        end

        it 'redirects to the created timeslot' do
          login_with user_customer
          post :create, params: { timeslot: timeslot_valid_time }, session: valid_session
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          login_with user_customer
          post :create, params: { timeslot: timeslot_invalid_time }, session: valid_session
          expect(response).not_to be_successful
        end
      end
    end
    context 'sign_in with user_manager role' do
      context 'with valid params' do
        it 'creates a new Timeslot' do
          login_with user_manager
          expect do
            post :create, params: { timeslot: timeslot_valid_time }, session: valid_session
          end.to change(Timeslot, :count).by(1)
        end

        it 'redirects to the created timeslot' do
          login_with user_manager
          post :create, params: { timeslot: timeslot_valid_time }, session: valid_session
          expect(response).to redirect_to(Timeslot.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          login_with user_manager
          post :create, params: { timeslot: timeslot_invalid_time }, session: valid_session
          expect(response).to be_successful
        end
      end
    end
    context 'sign_in with user_admin role' do
      context 'with valid params' do
        it 'creates a new Timeslot' do
          login_with user_admin
          expect do
            post :create, params: { timeslot: timeslot_valid_time }, session: valid_session
          end.to change(Timeslot, :count).by(1)
        end

        it 'redirects to the created timeslot' do
          login_with user_admin
          post :create, params: { timeslot: timeslot_valid_time }, session: valid_session
          expect(response).to redirect_to(Timeslot.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          login_with user_admin
          post :create, params: { timeslot: timeslot_invalid_time }, session: valid_session
          expect(response).to be_successful
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'sign_in with user_customer role' do
      context 'with valid params' do
        it 'updates the requested timeslot' do
          login_with user_customer
          put :update, params: { id: timeslot.to_param, timeslot: valid_time_update }, session: valid_session
          timeslot.reload
          expect(timeslot.start_time).to eql(valid_time_update[:start_time])
        end

        it 'redirects to the timeslot' do
          login_with user_customer
          put :update, params: { id: timeslot.to_param, timeslot: valid_time_update }, session: valid_session
          expect(response).to redirect_to(root_path)
        end
      end
      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          login_with user_customer
          put :update, params: { id: timeslot.to_param, timeslot: timeslot_invalid_time }, session: valid_session
          expect(response).not_to be_successful
        end
      end
    end
    context 'sign_in with user_manager role' do
      context 'with valid params' do
        it 'updates the requested timeslot' do
          login_with user_manager
          put :update, params: { id: timeslot.to_param, timeslot: valid_time_update }, session: valid_session
          timeslot.reload
          expect(timeslot.start_time).to eql(valid_time_update[:start_time])
        end

        it 'redirects to the timeslot' do
          login_with user_manager
          put :update, params: { id: timeslot.to_param, timeslot: valid_time_update }, session: valid_session
          expect(response).to redirect_to(timeslot)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          login_with user_manager
          put :update, params: { id: timeslot.to_param, timeslot: timeslot_invalid_time }, session: valid_session
          expect(response).to be_successful
        end
      end
    end
    context 'sign_in with user_admin role' do
      context 'with valid params' do
        it 'updates the requested timeslot' do
          login_with user_admin
          put :update, params: { id: timeslot.to_param, timeslot: valid_time_update }, session: valid_session
          timeslot.reload
          expect(timeslot.start_time).to eql(valid_time_update[:start_time])
        end

        it 'redirects to the timeslot' do
          login_with user_admin
          put :update, params: { id: timeslot.to_param, timeslot: valid_time_update }, session: valid_session
          expect(response).to redirect_to(timeslot)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          login_with user_admin
          put :update, params: { id: timeslot.to_param, timeslot: timeslot_invalid_time }, session: valid_session
          expect(response).to be_successful
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'sign_in with user_customer role' do
      let!(:timeslot) { FactoryBot.create(:timeslot_valid_time) }
      it 'destroys the requested timeslot' do
        login_with user_customer
        expect do
          delete :destroy, params: { id: timeslot.to_param }, session: valid_session
        end.to change(Timeslot, :count).by(0)
      end

      it 'redirects to the timeslots list' do
        login_with user_customer
        delete :destroy, params: { id: timeslot.to_param }, session: valid_session
        expect(response).to redirect_to(root_path)
      end
    end
    context 'sign_in with user_manager roles' do
      let!(:timeslot) { FactoryBot.create(:timeslot_valid_time) }
      it 'destroys the requested timeslot' do
        login_with user_manager
        expect do
          delete :destroy, params: { id: timeslot.to_param }, session: valid_session
        end.to change(Timeslot, :count).by(-1)
      end

      it 'redirects to the timeslots list' do
        login_with user_manager
        delete :destroy, params: { id: timeslot.to_param }, session: valid_session
        expect(response).to redirect_to(timeslots_url)
      end
    end
    context 'sign_in with user_admin role' do
      let!(:timeslot) { FactoryBot.create(:timeslot_valid_time) }
      it 'destroys the requested timeslot' do
        login_with user_admin
        expect do
          delete :destroy, params: { id: timeslot.to_param }, session: valid_session
        end.to change(Timeslot, :count).by(-1)
      end

      it 'redirects to the timeslots list' do
        login_with user_admin
        delete :destroy, params: { id: timeslot.to_param }, session: valid_session
        expect(response).to redirect_to(timeslots_url)
      end
    end
  end
end
