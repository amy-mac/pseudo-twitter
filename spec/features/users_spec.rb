require 'spec_helper'

feature 'Authentication' do
  scenario "logs in" do
    user = create(:user)
    sign_in(user)

    expect(current_path).to eq(root_path)
  end
end

describe "User pages" do

  subject { page }

  describe 'index page' do
    let(:user) { create(:user) }

    before do
      sign_in(create(:user))
      visit users_path
    end

    it { should have_selector('h3', text: 'All Users') }

    describe 'pagination' do
      before(:all) { 30.times { create(:user)} }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }

      it 'should list each user' do
        User.paginate(page: 1).each do |user|
          page.should have_link("@#{user.name}", href: user_path(user.name))
        end
      end
    end

  end

  describe "signup page" do
    before { visit new_user_path }

    let(:submit) { "Submit" }

    it { should have_selector('h1',    text: 'Sign Up') }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",                  with: "Example"
        fill_in "Email",                 with: "user@example.com"
        fill_in "Password",              with: "foobar"
        fill_in "Password confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "profile page" do
    let(:user) { create(:user) }
    let!(:tweet1) { create(:tweet, user_id: user.id) }
    let!(:tweet2) { create(:tweet, user_id: user.id) }

    before { visit user_path(user.name) }

    it { should have_selector('h2',    text: "@#{user.name}") }

    describe 'tweets' do
      it { should have_content(tweet1.tweet_text) }
      it { should have_content(tweet2.tweet_text) }
      it { should have_content(user.tweets.count) }
    end

    describe 'follow/unfollow buttons' do
      let(:other_user) { create(:user) }
      before { sign_in(user) }

      describe 'following a user' do
        before { visit user_path(other_user) }

        it 'should increment the followed user count' do
          expect{
            click_button 'Follow'
          }.to change(user.followed_users, :count).by(1)
        end

        it 'should increment the other user\'s follower count' do
          expect do
            click_button "Follow"
          end.to change(other_user.followers, :count).by(1)
        end

        describe 'toggling the button' do
          before { click_button "Follow" }
          it { should have_selector("input", text: "Unfollow") }
        end
      end

      describe 'unfollowing a user' do
        before do
          visit user_path(other_user)
          click_button "Follow"
        end

        it 'should decrease the followed user count' do
          expect{
            click_button "Unfollow"
          }.to change(user.followed_users, :count).by(-1)
        end

        it 'should decrease the other user\'s follower count' do
          expect{
            click_button 'Unfollow'
          }.to change(other_user.followers, :count).by(-1)
        end

        describe 'toggling the button' do
          before { click_button 'Unfollow' }
          it { should have_selector("input", 'Follow') }
        end
      end
    end
  end

  describe 'following/followers' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    before { user.follow!(other_user) }

    describe 'followed users page' do
      before do
        sign_in(user)
        visit following_user_path(user)
      end

      it { should have_selector('h3', 'Following') }
      it { should have_link(other_user.name, href: user_path(other_user.name))}
    end

    describe 'followers page' do
      before do
        sign_in(other_user)
        visit followers_user_path(other_user)
      end

      it { should have_selector('h3', 'Followers') }
      it { should have_link(user.name, href: user_path(user.name)) }
    end
  end
end
