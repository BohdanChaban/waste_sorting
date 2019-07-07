require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:valid_session) { {} }
  let(:valid_article) do
    { title: 'Test article',
      summary: 'Summary for article',
      body: 'Some body for article' }
  end

  let(:invalid_article) do
    { title: 'Test',
      summary: '',
      body: '' }
  end
  let!(:article) { FactoryBot.create(:valid_article) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: article.to_param }, session: valid_session
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
      get :edit, params: { id: article.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Article' do
        expect do
          post :create, params: { article: valid_article }, session: valid_session
        end.to change(Article, :count).by(1)
      end

      it 'redirects to the created article' do
        post :create, params: { article: valid_article }, session: valid_session
        expect(response).to redirect_to(Article.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { article: invalid_article }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested article' do
        put :update, params: { id: article.to_param, article: valid_article }, session: valid_session
        article.reload
        expect(article.title).to eql(valid_article[:title])
      end

      it 'redirects to the article' do
        put :update, params: { id: article.to_param, article: valid_article }, session: valid_session
        expect(response).to redirect_to(article)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: article.to_param, article: invalid_article }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested article' do
      expect do
        delete :destroy, params: { id: article.to_param }, session: valid_session
      end.to change(Article, :count).by(-1)
    end

    it 'redirects to the articles list' do
      delete :destroy, params: { id: article.to_param }, session: valid_session
      expect(response).to redirect_to(articles_url)
    end
  end
end
