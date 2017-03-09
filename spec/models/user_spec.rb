require 'rails_helper'

RSpec.describe User, type: :model do

  context "Validations" do
    it { should validate_presence_of(:email) }
  end

  context "Uniqueness" do
    it { should validate_uniqueness_of(:email) }
  end

  context "Relationships" do
    it { should have_many(:movies) }
  end
end
