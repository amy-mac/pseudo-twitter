require 'spec_helper'

describe TweetsController do
  include SessionsHelper

  let(:current_user) { create(:user) }
  
  describe "GET #new" do
    it 'renders the :new page' do
      get :new
      expect(response).to render_template :new
    end

    it 'creates an instance of the Tweet class' do
      get :new
      expect(assigns(:tweet)).to be_a_new(Tweet)
    end
  end

  describe "GET #show" do
    before(:each) do
      @tweet = create(:tweet)
    end

    it 'finds the requested tweet and assign it to :tweet' do
      get :show, id: @tweet
      expect(assigns(:tweet)).to eq(@tweet)
    end

    it 'renders the :show page' do
      get :show, id: @tweet
      expect(response).to render_template :show
    end
  end

  describe "POST #create" do
    # before(:each) do
      # @current_user = create(:user)
    # end

    context 'valid tweet input' do
      it 'creates a new tweet in the database' do
        expect{
          post :create, tweet: attributes_for(:tweet)
        }.to change(Tweet, :count).by(1)
      end

      it 'redirects to the user :show page' do
        post :create, tweet: attributes_for(:tweet)
        expect(response).to redirect_to user_path(current_user.name)
      end
    end

    context 'invalid tweet input' do
      it "doesn't create a new tweet in the database" do
        expect{
          post :create, tweet: attributes_for(:invalid_tweet)
        }.to_not change(Tweet, :count).by(1)
      end

      it "re-renders the :new template" do
        post :create, tweet: attributes_for(:invalid_tweet)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    it 'renders the :edit page' do
      get :edit, id: create(:tweet)
      expect(response).to render_template :edit
    end
  end

  describe "PUT #update" do
    context 'valid tweet input' do
      it 'updates the tweet attributes in the database'
      it 'redirects to the tweet :show page'
    end

    context 'invalid tweet input' do
      it "does not update tweet attributes in the database"
      it "re-renders the :edit template"
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @tweet = create(:tweet)
      @current_user = create(:user)
    end

    it 'deletes the tweet out of database' do
      expect{
        delete :destroy, id: @tweet
      }.to change(Tweet, :count).by(1)
    end

    it 'redirects to the user :show page' do
      delete :destroy, id: @tweet
      expect(response).to redirect_to user_path(current_user.name)
    end
  end

end
