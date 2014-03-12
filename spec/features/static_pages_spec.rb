require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do

    describe "for signed-in users" do
      let(:user) { create(:user) }
      before do
        create(:tweet, user: user, tweet_text: "Lorem")
        create(:tweet, user: user, tweet_text: "Ipsum")
        sign_in user
        visit root_path
      end

      # it "should render the user's feed" do
        # user.feed.each do |item|
          # page.should have_selector("li##{item.id}", text: item.content)
        # end
      # end

      describe "follower/following counts" do
        let(:other_user) { create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("following 0", href: following_user_path(user)) }
        it { should have_link("followers 1", href: followers_user_path(user)) }
      end
    end
  end
end
