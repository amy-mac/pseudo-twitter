require 'spec_helper'

describe 'Authentication' do

  subject { page }

  describe "signin page" do
    before { visit new_session_path }

    it { should have_selector('h1',    text: 'Sign In') }

    describe 'with invalid information' do
      before { click_button 'Sign In' }

      it { should have_selector('div.small-12.columns.alert-box.warning',
        text: 'Sorry, your email or password is incorrect') }

      describe "after visiting another page" do
        before { click_link "Pseudo-Twitter" }
        it { should_not have_selector('div.small-12.columns.alert-box.warning') }
      end
    end

    describe 'with valid information' do
      let(:user) { create(:user) }

      before do
        fill_in "Name", with: user.name
        fill_in "Password", with: user.password
        click_button 'Sign In'
      end

      it { should have_link('Users', href: users_path) }
      it { should have_link('New Tweet', href: new_tweet_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should_not have_link('Sign In', href: new_session_path) }

      describe 'followed by signout' do
        before { click_link 'Sign Out' }
        it { should have_link('Sign In') }
      end
    end
  end

  describe 'authorization' do

    describe 'for non signed-in users' do
      let(:user) { create(:user) }

      describe 'in the users controller' do
        describe 'visit the following page' do
          before { visit following_user_path(user) }
          it { should have_selector('h1', 'Sign In') }
        end

        describe 'visit the followers page' do
          before { visit followers_user_path(user) }
          it { should have_selector('h1', 'Sign In') }
        end
      end

      # describe 'in the relationships controller' do
      #   describe 'submitting to the create action' do
      #     before do
      #       post relationships_path
      #     end
      #     specify { response.should redirect_to new_session_path }
      #   end
      #
      #   describe 'submitting to the destroy action' do
      #     before { delete relationship_path(1) }
      #     specify { response.should redirect_to new_session_path }
      #   end
      # end

    end
    describe 'for signed-in users' do

    end
  end

end
