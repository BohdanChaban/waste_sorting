require 'rails_helper'

RSpec.describe InquiriesController, type: :controller do
  let(:inquiry_valid_status) do
    { status: 'initiated', timeslot_id: timeslot.id}
  end

  let(:inquiry_invalid_status) do
    { status: ' ' }
  end

  let(:inquiry_valid_status_update) do
    { status: 'initiated', }
  end

  let(:timeslot_valid_time) do
    { start_time: Time.new(2019, 0o2, 24, 12, 0, 0, '+09:00'), district_id: district.id }
  end

  let(:district_valid_name) do
    { name: 'Львівський'}
  end
  let(:district) { FactoryBot.create(:district_valid_name) }
  let(:timeslot) { FactoryBot.create(:timeslot_valid_time) }
  let(:user_customer) { FactoryBot.create(:user_customer) }
  let(:user_manager) { FactoryBot.create(:user_manager) }
  let(:user_admin) { FactoryBot.create(:user_admin) }
  let(:inquiry) { FactoryBot.create(:inquiry_valid_status) }

  let(:valid_session) { {} }

  let(:valid_session) { {} }
  describe 'GET #index' do
    context 'sign_in with user_admin role' do
      it 'returns a success response' do
        login_with user_admin
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
    context 'sign_in with user_customer role' do
      it 'returns a success response' do
        login_with user_customer
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #show' do
    context 'sign_in with user_admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :show, params: { id: inquiry.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with user_manager role' do
      it 'returns a success response' do
        login_with user_manager
        get :show, params: { id: inquiry.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with user_customer role' do
      it 'returns a success response' do
        login_with user_customer
        get :show, params: { id: inquiry.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #new' do
    context 'sign_in with user_admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :new, params: {}, session: valid_session
        expect(response).not_to be_successful
      end
    end
    context 'sign_in with user_manager role' do
      it 'returns a success response' do
        login_with user_manager
        get :new, params: {}, session: valid_session
        expect(response).not_to be_successful
      end
    end
    context 'sign_in with user_customer role' do
      it 'returns a success response' do
        login_with user_customer
        get :new, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #edit' do
    context 'sign_in with user_admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :edit, params: { id: inquiry.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with user_manager role' do
      it 'returns a success response' do
        login_with user_manager
        get :edit, params: { id: inquiry.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with user_customer role' do
      it 'returns a success response' do
        login_with user_customer
        get :edit, params: { id: inquiry.to_param }, session: valid_session
        expect(response).not_to be_successful
      end
    end
  end

  describe 'POST #create' do
    context 'sign_in with user_admin role' do
      context 'with valid params' do
        it 'creates a new Inquiry' do
          login_with user_admin
          expect do
            post :create, params: { inquiry: inquiry_valid_status }, session: valid_session
          end.to change(Inquiry, :count).by(0)
        end

        it 'redirects to the created inquiry' do
          login_with user_admin
          post :create, params: { inquiry: inquiry_valid_status }, session: valid_session
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          login_with user_admin
          post :create, params: { inquiry: inquiry_invalid_status }, session: valid_session
          expect(response).not_to be_successful
        end
      end
    end

    context 'sign_in with user_manager role' do
      context 'with valid params' do
        it 'creates a new Inquiry' do
          login_with user_manager
          expect do
            post :create, params: { inquiry: inquiry_valid_status }, session: valid_session
          end.to change(Inquiry, :count).by(0)
        end

        it 'redirects to the created inquiry' do
          login_with user_manager
          post :create, params: { inquiry: inquiry_valid_status }, session: valid_session
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          login_with user_manager
          post :create, params: { inquiry: inquiry_invalid_status }, session: valid_session
          expect(response).not_to be_successful
        end
      end
    end

    context 'sign_in with user_customer role' do
      context 'with valid params' do
        it 'creates a new Inquiry' do
          login_with user_customer
          expect do
            post :create, params: { inquiry: inquiry_valid_status }, session: valid_session
          end.to change(Inquiry, :count).by(1)
        end

        it 'redirects to the created inquiry' do
          login_with user_customer
          post :create, params: { inquiry: inquiry_valid_status }, session: valid_session
          expect(response).to redirect_to(Inquiry.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          login_with user_customer
          post :create, params: { inquiry: inquiry_invalid_status }, session: valid_session
          expect(response).to be_successful
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'sign_in with user_admin role' do
      context 'with valid params' do
        it 'updates the requested inquiry' do
          login_with user_admin
          put :update, params: { id: inquiry.to_param, inquiry: inquiry_valid_status_update }, session: valid_session
          inquiry.reload
          expect(inquiry.status).to eql(inquiry_valid_status_update[:status])
        end

        it 'redirects to the inquiry' do
          login_with user_admin
          put :update, params: { id: inquiry.to_param, inquiry: inquiry_valid_status_update }, session: valid_session
          expect(response).to redirect_to(inquiry)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          login_with user_admin
          put :update, params: { id: inquiry.to_param, inquiry: inquiry_invalid_status }, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    context 'sign_in with user_manager role' do
      context 'with valid params' do
        it 'updates the requested inquiry' do
          login_with user_manager
          put :update, params: { id: inquiry.to_param, inquiry: inquiry_valid_status_update }, session: valid_session
          inquiry.reload
          expect(inquiry.status).to eql(inquiry_valid_status_update[:status])
        end

        it 'redirects to the inquiry' do
          login_with user_manager
          put :update, params: { id: inquiry.to_param, inquiry: inquiry_valid_status_update }, session: valid_session
          expect(response).to redirect_to(inquiry)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          login_with user_manager
          put :update, params: { id: inquiry.to_param, inquiry: inquiry_invalid_status }, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    context 'sign_in with user_customer role' do
      context 'with valid params' do
        it 'updates the requested inquiry' do
          login_with user_customer
          put :update, params: { id: inquiry.to_param, inquiry: inquiry_valid_status_update }, session: valid_session
          inquiry.reload
          expect(inquiry.status).to eql(inquiry_valid_status_update[:status])
        end

        it 'redirects to the inquiry' do
          login_with user_customer
          put :update, params: { id: inquiry.to_param, inquiry: inquiry_valid_status_update }, session: valid_session
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          login_with user_customer
          put :update, params: { id: inquiry.to_param, inquiry: inquiry_invalid_status }, session: valid_session
          expect(response).not_to be_successful
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'sign_in with user_admin role' do
      let!(:inquiry) { FactoryBot.create(:inquiry_valid_status) }
      it 'destroys the requested inquiry' do
        login_with user_admin
        expect do
          delete :destroy, params: { id: inquiry.to_param }, session: valid_session
        end.to change(Inquiry, :count).by(-1)
      end

      it 'redirects to the inquiries list' do
        login_with user_admin
        delete :destroy, params: { id: inquiry.to_param }, session: valid_session
        expect(response).to redirect_to(inquiries_url)
      end
    end

    context 'sign_in with user_manager role' do
      let!(:inquiry) { FactoryBot.create(:inquiry_valid_status) }
      it 'destroys the requested inquiry' do
        login_with user_manager
        expect do
          delete :destroy, params: { id: inquiry.to_param }, session: valid_session
        end.to change(Inquiry, :count).by(-1)
      end

      it 'redirects to the inquiries list' do
        login_with user_manager
        delete :destroy, params: { id: inquiry.to_param }, session: valid_session
        expect(response).to redirect_to(inquiries_url)
      end
    end

    context 'sign_in with user_customer role' do
      let!(:inquiry) { FactoryBot.create(:inquiry_valid_status) }
      it 'destroys the requested inquiry' do
        login_with user_customer
        expect do
          delete :destroy, params: { id: inquiry.to_param }, session: valid_session
        end.to change(Inquiry, :count).by(0)
      end

      it 'redirects to the inquiries list' do
        login_with user_customer
        delete :destroy, params: { id: inquiry.to_param }, session: valid_session
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
