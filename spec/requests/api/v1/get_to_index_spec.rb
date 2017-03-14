require "rails_helper"

describe "GET /movies" do
  context "gets all movies" do
    scenario "that are sorted alpha" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      movie1 = create(:movie, title: "Delta", user: user)
      movie3 = create(:movie, title: "Beta")
      movie2 = create(:movie, title: "Alpha", user: user)

      expect(Movie.last.title).to eq("Alpha")

      get '/api/v1/movies'

      movies = JSON.parse(response.body)

      expect(response).to be_success
      expect(movies.count).to eq(2)
      expect(movies.first["title"]).to eq("Alpha")
    end
  end
end
