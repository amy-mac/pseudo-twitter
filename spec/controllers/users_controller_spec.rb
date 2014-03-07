require 'spec_helper'
require 'pry'

describe UsersController do
  describe "GET #index" do
    it "renders the :index view"
  end

  describe "GET #show" do
    before(:each) do
      @user = create(:user)
    end

    it "assigns requested user to @user" do
      get :show, id: @user
      expect(assigns(:user)).to eq(@user)
    end

    it "renders the :show view" do
      get :show, id: @user
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "renders the :new view" do
      get :new
      expect(response).to render_template :new
    end

    it "creates a new instance of the User class" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    context "valid input" do
      it "adds new user to database" do
        expect{
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it 'redirects to user#show' do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to user_path(assigns(:user).name)
      end
    end

    context "invalid input" do
      it "doesn't add new user to database" do
        expect{
          post :create, user: attributes_for(:invalid_user)
        }.to_not change(User, :count)
      end

      it "re-renders the :new page" do
        post :create, user: attributes_for(:invalid_user)
        expect(response).to render_template :new
      end

      it "renders an error message"
    end
  end

  describe "GET #edit" do
    it "renders the :edit view"
  end

  describe "PUT #update" do

  end

  describe "DELETE #destroy" do
    it "deletes user out of database"
    it "redirects to home page"
  end
end
