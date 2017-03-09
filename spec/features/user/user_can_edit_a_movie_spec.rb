require "rails_helper"

describe "As an authenticated user," do
  context "I can click on the edit button for a movie," do
    scenario "And be taken to a page to edit its info." do

      user = create(:user)
      movie = create(:movie, user: user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      click_on "Edit"

      expect(current_path).to eq(edit_movie_path(movie))

      fill_in 'movie[title]', with: "LOTR"
      fill_in 'movie[note]', with: "Trilogoy"

      click_on "Update Movie"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("LOTR")
      expect(page).to have_content("Trilogoy")
    end

    scenario "If I dont have a title" do

      user = create(:user)
      movie = create(:movie, user: user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      click_on "Edit"

      expect(current_path).to eq(edit_movie_path(movie))

      fill_in 'movie[title]', with: ""

      click_on "Update Movie"

      expect(current_path).to eq(edit_movie_path(movie))
      expect(page).to have_content("Sorry, you need to have a title")

    end
  end
end
