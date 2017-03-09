require "rails_helper"

describe "GET /movies" do
  context "gets all movies" do
    scenario "that are sorted alpha" do
      movie1 = create(:movie, title: "Delta")
      movie2 = create(:movie, title: "Alpha")

      expect(Movie.last.title).to eq("Alpha")

      get '/api/v1/movies'

      movies = JSON.parse(response.body)

      expect(response).to be_success
      expect(movies.count).to eq(2)
      expect(movies.first["title"]).to eq("Alpha")
    end
  end
end
