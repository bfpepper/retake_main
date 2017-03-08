require 'rails_helper'

describe 'As a signed in user' do
  context 'In order to sign out' do
    scenario 'I see a link to log out' do

      user = create(:user)

      visit root_path

      click_on("Log In")

      expect(current_path).to eq(login_path)

      fill_in :Email, with: user.email
      fill_in :Password, with: user.password

      click_on("Sign In")

      expect(page).to have_content("Log Out")

      click_on('Log Out')

      expect(page).to have_content("Log In")
      expect(page).to have_content("Sign Up")
    end
  end
end
