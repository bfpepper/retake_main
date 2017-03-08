FactoryGirl.define do
  factory :user do
    email
    password
  end

  sequence :email do |n|
    "test#{n}@turing.io"
  end

  sequence :password do |n|
    "this#{n}password"
  end

end
