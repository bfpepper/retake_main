require "rails_helper"

describe "When I send a patch request" do
  context  "to /api/v1/movies/:id" do
    scenario "the db updates correctly" do

      movie = create(:movie)

      data = { watched: true}

      put "/api/v1/movies/#{movie.id}", data.to_json, { 'CONTENT_TYPE' => 'application/json'}

      expect(Movie.first.watched).to eq(true)
    end
  end
end
