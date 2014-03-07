require 'spec_helper'

describe User do
  context 'valid user entry' do
    it 'has a name, password, and email' do
      expect(build(:user)).to be_valid
    end

    it 'converts email to downcase before saving' do
      user = create(:user, email: 'TEST@TEST.com')
      expect(user.email).to eq('test@test.com')
    end

    it 'has a properly formatted email address' do
      expect(build(:user, email: 'test.com')).to have(1).errors_on(:email)
    end
  end

  context 'invalid user entry' do
    it 'has no name' do
      expect(build(:user, name: nil)).to have(1).errors_on(:name)
    end

    it 'has no email' do
      expect(build(:user, email: nil)).to have(2).errors_on(:email)
    end

    it 'is a duplicate email address' do
      user = create(:user, email: 'foo@bar.com')
      expect(build(:user, email: 'foo@bar.com')).to have(1).errors_on(:email)
    end

    it 'is a duplicate name' do
      user = create(:user, name: 'bob')
      expect(build(:user, name: 'bob')).to have(1).errors_on(:name)
    end

    it 'has no password' do
      expect(build(:user, password: nil, password_confirmation: nil)).to have(2).errors_on(:password)
    end

    it 'has no password_confirmation' do
      expect(build(:user, password_confirmation: nil)).to have(1).errors_on(:password_confirmation)
    end
    
    it 'has a password and password_confirmation that don\'t match' do
      user = build(:user, password: 'testing', password_confirmation: 'foobar')
      expect(user).to have(1).errors_on(:password)
    end

    it 'has a password that is too short' do
      expect(build(:user, password: 'foo', password_confirmation: 'foo')).to have(1).errors_on(:password)
    end
  end

end
