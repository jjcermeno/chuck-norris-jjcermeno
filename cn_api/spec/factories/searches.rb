FactoryBot.define do
  factory :search do
    id { Faker::Number.within(range: 1..10000000) }
    search_type { ["word", "category", "random"].sample }
    search_value { Faker::Space.planet }
    email { Faker::Internet.email }
    jokes { create_list(:joke, (1..5).to_a.sample) }
  end
end
