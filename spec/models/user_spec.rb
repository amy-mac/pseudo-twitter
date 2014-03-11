require 'spec_helper'

describe User do
  let(:user) { create(:user) }

  subject { user }

  describe 'class methods' do
    it { should respond_to :authenticate }
    it { should respond_to :relationships }
    it { should respond_to :reverse_relationships }
    it { should respond_to :followed_users }
    it { should respond_to :tweets }
    it { should respond_to :follow! }
    it { should respond_to :following? }
    it { should respond_to :unfollow! }
  end

  describe 'entry' do
    context 'is valid' do
      it 'has a name, password, and email' do
        expect(user).to be_valid
      end

      it 'has a properly formatted email address' do
        expect(build(:user, email: 'test.com')).to have(1).errors_on(:email)
      end

      it 'generates a :remember_token before saving' do
        expect(user.remember_token).to_not eq(nil)
      end

    end

    context 'is invalid' do
      it 'has no name' do
        expect(build(:user, name: nil)).to have(1).errors_on(:name)
      end

      it 'has no email' do
        expect(build(:user, email: nil)).to have(2).errors_on(:email)
      end

      it 'is a duplicate email address' do
        expect(build(:user, email: user.email)).to have(1).errors_on(:email)
      end

      it 'is a duplicate name' do
        expect(build(:user, name: user.name)).to have(1).errors_on(:name)
      end

      it 'has no password' do
        expect(build(:user, password: nil, password_confirmation: nil)).to have(2).errors_on(:password)
      end

      it 'has no password_confirmation' do
        expect(build(:user, password_confirmation: nil)).to have(1).errors_on(:password_confirmation)
      end

      it 'has a password and password_confirmation that don\'t match' do
        user2 = build(:user, password: 'testing', password_confirmation: 'foobar')
        expect(user2).to have(1).errors_on(:password)
      end

      it 'has a password that is too short' do
        expect(build(:user, password: 'foo', password_confirmation: 'foo')).to have(1).errors_on(:password)
      end
    end
  end

  describe 'following' do
    let(:other_user) { create(:user) }
    before do
      user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }

    describe 'and unfollowing' do
      before do
        user.unfollow!(other_user)
      end

      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end

    describe 'followed user' do
      subject { other_user }
      its(:followers) { should include(user) }
    end
  end
end
