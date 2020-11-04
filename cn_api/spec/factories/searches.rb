FactoryBot.define do
  factory :search do
    search_type { Faker::Space.planet }
    email       { Faker::Internet.email }
    jokes { create_list(:joke, 5) }
  end
end
