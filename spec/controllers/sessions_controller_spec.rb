require 'spec_helper'
require 'pry'

describe SessionsController do
  include SessionsHelper

  describe "GET #new" do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do

    context 'valid user input' do
      before(:each) do
        @example_user = create(:user)
      end

      # it 'finds the user in the database' do
        # post :create, email: @example_user.email, password: @example_user.password
        # expect(assigns(:user)).to eq(@example_user)
      # end

      # it 'creates a new session for the user' do
        # expect{
          # post :create, session: {attributes_for(@example_user)}
        # }.to
        # expect(cookies[:remember_token]).to_not eq(nil)
      # end
    end

    context 'invalid user input' do
      it 'does not create a new session' do
        expect(session[:user_id]).to eq(nil)
      end

      it 're-renders the :new template' do
        expect(response).to render_template :new
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = create(:user)
    end

    it 'deletes the current user session' do
      delete :destroy, id: @user
      expect(session[:user_id]).to eq(nil)
    end

    it 'redirects to home page' do
      delete :destroy, id: @user
      expect(response).to redirect_to root_path
    end
  end
end
