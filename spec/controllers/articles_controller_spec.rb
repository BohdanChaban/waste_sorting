require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:valid_session) { {} }
  let(:valid_article) do
    { title: 'Some title',
      summary: 'This is summary',
      body: 'Input text here' }
  end

  let(:invalid_article) do
    { title: 'Test',
      summary: '',
      body: '' }
  end

  let(:user_customer) { FactoryBot.create(:user_customer) }
  let(:user_admin) { FactoryBot.create(:user_admin) }
  let!(:article) { FactoryBot.create(:valid_article) }

  describe 'GET #index' do
    context 'sign_in with admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with customer role' do
      it 'returns a success response' do
        login_with user_customer
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #new' do
    context 'sign_in with admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :new, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with costumer role' do
      it 'returns a success response' do
        login_with user_customer
        get :new, params: {}, session: valid_session
        expect(response).not_to be_successful
      end
    end
  end

  describe 'GET #edit' do
    context 'sign_in with admin role' do
      it 'returns a success response' do
        login_with user_admin
        get :edit, params: { id: article.to_param }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'sign_in with costumer role' do
      it 'returns a success response' do
        login_with user_customer
        get :edit, params: { id: article.to_param }, session: valid_session
        expect(response).not_to be_successful
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params admin user' do
      it 'creates a new Article' do
        login_with user_admin
        expect do
          post :create, params: { article: valid_article }, session: valid_session
        end.to change(Article, :count).by(1)
      end

      it 'redirects to the created article' do
        login_with user_admin
        post :create, params: { article: valid_article }, session: valid_session
        expect(response).to redirect_to(Article.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        login_with user_admin
        post :create, params: { article: invalid_article }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'with valid params customer user' do
      it 'creates a new Article' do
        login_with user_customer
        expect do
          post :create, params: { article: valid_article }, session: valid_session
        end.to change(Article, :count).by(0)
      end

      it 'redirects to the created article' do
        login_with user_customer
        post :create, params: { article: valid_article }, session: valid_session
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        login_with user_customer
        post :create, params: { article: invalid_article }, session: valid_session
        expect(response).not_to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params admin role' do
      it 'updates the requested article' do
        login_with user_admin
        put :update, params: { id: article.to_param, article: valid_article }, session: valid_session
        article.reload
        expect(article.title).to eql(valid_article[:title])
      end

      it 'redirects to the article' do
        login_with user_admin
        put :update, params: { id: article.to_param, article: valid_article }, session: valid_session
        expect(response).to redirect_to(article)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        login_with user_admin
        put :update, params: { id: article.to_param, article: invalid_article }, session: valid_session
        expect(response).to be_successful
      end
    end
    context 'with valid params customer role' do
      it 'updates the requested article' do
        login_with user_customer
        put :update, params: { id: article.to_param, article: valid_article }, session: valid_session
        article.reload
        expect(article.title).to eql(valid_article[:title])
      end

      it 'redirects to the article' do
        login_with user_customer
        put :update, params: { id: article.to_param, article: valid_article }, session: valid_session
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        login_with user_customer
        put :update, params: { id: article.to_param, article: invalid_article }, session: valid_session
        expect(response).not_to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid params admin role' do
      it 'destroys the requested article' do
        login_with user_admin
        expect do
          delete :destroy, params: { id: article.to_param }, session: valid_session
        end.to change(Article, :count).by(-1)
      end

      it 'redirects to the articles list' do
        login_with user_admin
        delete :destroy, params: { id: article.to_param }, session: valid_session
        expect(response).to redirect_to(articles_url)
      end
    end
  end
  context 'with valid params customer role' do
    it 'destroys the requested article' do
      login_with user_customer
      expect do
        delete :destroy, params: { id: article.to_param }, session: valid_session
      end.to change(Article, :count).by(0)
    end

    it 'redirects to the articles list' do
      login_with user_customer
      delete :destroy, params: { id: article.to_param }, session: valid_session
      expect(response).to redirect_to(root_path)
    end
  end
end
