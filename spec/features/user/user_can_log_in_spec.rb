require 'rails_helper'

describe 'As a registered user' do
  context 'When I visit the root page' do
    scenario 'I see a link to log in and can log in' do

      user = create(:user)

      visit root_path

      click_on("Log In")

      expect(current_path).to eq(login_path)

      fill_in :Email, with: user.email
      fill_in :Password, with: user.password

      click_on("Sign In")

      expect(current_path).to eq(root_path)
    end

    scenario "I enter the wrong email and can not log in" do

      user = create(:user)

      visit root_path

      click_on("Log In")

      expect(current_path).to eq(login_path)

      fill_in :Email, with: "this@this.com"
      fill_in :Password, with: user.password

      click_on("Sign In")

      expect(current_path).to eq(login_path)
    end

    scenario "I enter the wrong password and can not log in" do

      user = create(:user)

      visit root_path

      click_on("Log In")

      expect(current_path).to eq(login_path)

      fill_in :Email, with: user.email
      fill_in :Password, with: "doesthiswork?"

      click_on("Sign In")

      expect(current_path).to eq(login_path)
    end

    scenario "I must enter a password" do

      user = create(:user)

      visit root_path

      click_on("Log In")

      expect(current_path).to eq(login_path)

      fill_in :Email, with: user.email
      fill_in :Password, with: nil

      click_on("Sign In")

      expect(current_path).to eq(login_path)

    end
    scenario "I must enter an email" do

      user = create(:user)

      visit root_path

      click_on("Log In")

      expect(current_path).to eq(login_path)

      fill_in :Email, with: nil
      fill_in :Password, with: user.password

      click_on("Sign In")

      expect(current_path).to eq(login_path)

    end
  end
end
