require 'spec_helper'

describe Tweet do
  context 'valid tweet entry' do
    it 'has :tweet_text and a :user_id' do
      expect(create(:tweet)).to be_valid
    end

  end

  context 'invalid tweet entry' do
    it 'is blank' do
      tweet = build(:tweet, tweet_text: nil, user_id: 3)
      expect(tweet).to have(1).errors_on(:tweet_text)
    end

    it 'is longer than 140 characters' do
      tweet = build(:invalid_tweet, user_id: 2)
      expect(tweet).to have(1).errors_on(:tweet_text)
    end

    it 'has no :user_id' do
      tweet = build(:invalid_tweet)
      expect(tweet).to have(1).errors_on(:user_id)
    end
  end
end
