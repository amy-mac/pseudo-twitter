require 'spec_helper'

describe 'Tweet pages' do

  subject { page }

  let(:user) { create(:user) }
  before { sign_in(user) }

  describe "tweet creation" do
    before {
      visit root_path
    }
    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Tweet" }.not_to change(Tweet, :count)
      end

      describe "error messages" do
        before { click_button "Tweet" }
        it { should have_content('Oops') }
      end
    end

    describe "with valid information" do

      before { fill_in 'tweet_tweet_text', with: "Lorem ipsum" }

      it "should create a tweet" do
        expect { click_button "Tweet" }.to change(Tweet, :count).by(1)
      end
    end
  end


end
