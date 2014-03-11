require 'spec_helper'

describe Tweet do
  let(:user) { create(:user) }
  let(:tweet) { user.tweets.build(tweet_text: "Hello World!") }

  subject { tweet }

  describe 'accessible attributes' do
    it 'does not allow access to :user_id' do
      expect{
        Tweet.new(user_id: 1)
      }.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe 'association methods' do
    it { should respond_to :user }
    its(:user) { should == user }
  end

  context 'valid tweet entry' do
    it 'has :tweet_text and a :user_id' do
      expect(tweet).to be_valid
    end
  end

  context 'invalid tweet entry' do
    it 'is blank' do
      tweet.tweet_text = nil
      tweet.save
      expect(tweet).to have(1).errors_on(:tweet_text)
    end

    it 'is longer than 140 characters' do
      tweet2 = build(:invalid_tweet, user_id: 2)
      expect(tweet2).to have(1).errors_on(:tweet_text)
    end

    it 'has no :user_id' do
      tweet2 = build(:invalid_tweet)
      expect(tweet2).to have(1).errors_on(:user_id)
    end
  end
end
