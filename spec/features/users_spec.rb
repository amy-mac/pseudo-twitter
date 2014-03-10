require 'spec_helper'

feature 'Authentication' do
  scenario "logs in" do
    user = create(:user)
    sign_in(user)
    save_and_open_page

    expect(current_path).to eq(users_path)

  end
end
