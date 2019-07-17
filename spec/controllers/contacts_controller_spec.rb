require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:valid) { {} }
  let(:valid_attributes) do
    { name: 'Head Office Waste Sorting LTD',
      address: 'Shevchenka St, 111A, Lviv',
      email: 'head@office.com',
      mobile_number: '+38000000000',
      facebook: 'http://fb.com/waste_sorting',
      instagram: 'instagram.com/waste_sorting',
      other_info: 'Zip Code: 79000' }
  end

  let(:invalid_attributes) do
    { name: '' }
  end

  let(:user_customer) { FactoryBot.create(:user_customer) }

  let(:user_admin) { FactoryBot.create(:user_admin) }

  let!(:contact) { FactoryBot.create(:valid_attributes) }

  describe 'GET #index' do
    context 'sign_in with admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :index, params: {}, session: valid
        expect(response).to be_successful
      end
    end

    context 'sign_in with customer role' do
      it 'returns a success response' do
        login_with user_customer
        get :index, params: {}, session: valid
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #new' do
    context 'sign_in with admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :new, params: {}, session: valid
        expect(response).to be_successful
      end
    end
    context 'sign_in with customer role' do
      it 'returns a not success response' do
        login_with user_customer
        get :new, params: {}, session: valid
        expect(response).not_to be_successful
      end
    end
  end

  describe 'GET #edit' do
    context 'sign_in with admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :edit, params: { id: contact.to_param }, session: valid
        expect(response).to be_successful
      end
    end
    context 'sign_in with customer role' do
      it 'returns a success response' do
        login_with user_customer
        get :edit, params: { id: contact.to_param }, session: valid
        expect(response).not_to be_successful
      end
    end
  end

  describe 'POST #create' do
    context 'sign_in with admin role' do
      context 'with valid params' do
        it 'creates a new Contact' do
          login_with user_admin
          expect do
            post :create, params: { contact: valid_attributes }, session: valid
          end.to change(Contact, :count).by(1)
        end

        it 'redirects to the created contact' do
          login_with user_admin
          post :create, params: { contact: valid_attributes }, session: valid
          expect(response).to redirect_to(contacts_path)
        end
      end

      xcontext 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          login_with user_admin
          post :create, params: { contact: invalid_attributes }, session: valid
          expect(response).to be_successful
        end
      end
    end
    context 'sign_in with customer role' do
      context 'with valid params' do
        it 'creates a new Contact' do
          login_with user_customer
          expect do
            post :create, params: { contact: valid_attributes }, session: valid
          end.to change(Contact, :count).by(0)
        end

        it 'redirects to root_path' do
          login_with user_customer
          post :create, params: { contact: valid_attributes }, session: valid
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          login_with user_customer
          post :create, params: { contact: invalid_attributes }, session: valid
          expect(response).not_to be_successful
        end
      end
    end
  end

  describe 'PUT #update' do
    xcontext 'sign_in with admin role' do
      context 'with updated params' do
        let(:updated_attributes) do
          { address: 'Шевченка 111а' }
        end

        it 'updates the requested contact' do
          login_with user_admin
          put :update, params: { id: contact.to_param, contact: updated_attributes }, session: valid
          contact.reload
        end

        it 'redirects to the contact' do
          login_with user_admin
          put :update, params: { id: contact.to_param, contact: valid_attributes }, session: valid
          expect(response).to redirect_to(contacts_path)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          login_with user_admin
          put :update, params: { id: contact.to_param, contact: invalid_attributes }, session: valid
          expect(response).to be_successful
        end
      end
    end
    context 'sign_in with customer role' do
      context 'with updated params' do
        let(:updated_attributes) do
          { address: 'Шевченка 111а' }
        end

        it 'updates the requested contact' do
          login_with user_customer
          put :update, params: { id: contact.to_param, contact: updated_attributes }, session: valid
          contact.reload
        end

        it 'redirects to root_path' do
          login_with user_customer
          put :update, params: { id: contact.to_param, contact: valid_attributes }, session: valid
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'edit' template)" do
          login_with user_customer
          put :update, params: { id: contact.to_param, contact: invalid_attributes }, session: valid
          expect(response).not_to be_successful
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    xit 'destroys the requested contact' do
      contact = Contact.create! valid_attributes
      expect do
        delete :destroy, params: { id: contact.to_param }, session: valid
      end.to change(Contact, :count).by(-1)
    end

    xit 'redirects to the contacts list' do
      contact = Contact.create! valid_attributes
      delete :destroy, params: { id: contact.to_param }, session: valid
      expect(response).to redirect_to(contacts_url)
    end
  end
end
