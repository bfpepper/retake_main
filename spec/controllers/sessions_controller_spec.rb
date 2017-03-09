require 'rails_helper'

describe SessionsController, type: :controller do
  context "new" do
    scenario "it redirects to the right place" do
      get :new

      expect(response).to have_http_status(200)
    end
  end

  context "create" do
    scenario "with a stubbed logged in user there is a user" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect(User.count).to eq(1)
    end
  end

  context "destroy" do
    scenario "user no longer has authentication and is redirected" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect(response).to have_http_status(200)

      post :destroy

      expect(response).to have_http_status(302)
    end
  end
end
