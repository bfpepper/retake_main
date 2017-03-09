FactoryGirl.define do
  factory :movie do
    title
    note
    watched false
    user
  end

  sequence :title do |n|
    "title#{n}"
  end

  sequence :note do |n|
    "note#{n}"
  end
  
end
