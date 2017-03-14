require 'rails_helper'

describe 'As an authenticated user,' do
  context 'when viewing movies#index,' do
    scenario 'I see a form to submit a new movie' do

      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      fill_in 'movie[title]', with: "LOTR"
      fill_in 'movie[note]', with: "Trilogoy"

      click_on "Create Movie"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Lotr")
    end

    scenario 'cannot submit an invalid Movie' do

      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      fill_in 'movie[note]', with: "Trilogoy"

      click_on "Create Movie"

      expect(Movie.count).to eq(0)
    end

    scenario 'I see a form to submit a new movie' do

      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      fill_in 'movie[title]', with: "LOTR \\cc: test@test.com"
      fill_in 'movie[note]', with: "Trilogoy"

      click_on "Create Movie"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Lotr")
    end
  end
end
