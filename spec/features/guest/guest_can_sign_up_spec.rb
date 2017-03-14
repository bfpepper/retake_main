require 'rails_helper'

describe 'As a guest' do
  context 'when I visit /users/new' do
    scenario 'I can sign up for a new account' do

      user = build(:user)

      visit new_user_path
      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
      expect(page).to have_content("Password confirmation")

      fill_in :Email, with: user.email
      fill_in :Password, with: user.password
      fill_in "user[password_confirmation]", with: user.password

      click_on("Create Account")

      expect(current_path).to eq(root_path)
    end

    scenario "If I dont enter the right password twice I dont get to create an account" do

      user = build(:user)

      visit new_user_path

      fill_in :Email, with: user.email
      fill_in :Password, with: user.password
      fill_in "user[password_confirmation]", with: "NotAPassword"

      click_on("Create Account")

      expect(current_path).to eq(new_user_path)
    end

    scenario "If I enter an existing email I dont get to create an account" do

      user_1 = create(:user)
      user_2 = build(:user)

      visit new_user_path

      fill_in :Email, with: user_1.email
      fill_in :Password, with: user_2.password
      fill_in "user[password_confirmation]", with: user_2.password

      click_on("Create Account")

      expect(current_path).to eq(new_user_path)
    end

    scenario "If I dont enter password but enter confirmation I dont get to create an account" do

      user = build(:user)

      visit new_user_path

      fill_in :Email, with: user.email
      fill_in :Password, with: nil
      fill_in "user[password_confirmation]", with: user.password

      click_on("Create Account")

      expect(current_path).to eq(new_user_path)
    end

    scenario "If I enter password but not confirmation I dont get to create an account" do

      user = build(:user)

      visit new_user_path

      fill_in :Email, with: user.email
      fill_in :Password, with: user.password
      fill_in "user[password_confirmation]", with: nil

      click_on("Create Account")

      expect(current_path).to eq(new_user_path)
    end

    scenario "If I must enter an email" do

      user = build(:user)

      visit new_user_path

      fill_in :Email, with: nil
      fill_in :Password, with: user.password
      fill_in "user[password_confirmation]", with: user.password

      click_on("Create Account")

      expect(current_path).to eq(new_user_path)
    end
  end
end
