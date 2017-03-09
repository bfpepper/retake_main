require 'rails_helper'

RSpec.describe Movie, type: :model do

  context "Validations" do
    it { should validate_presence_of(:title) }
  end

  context "Relationships" do
    it { should belong_to(:user) }
  end
end
