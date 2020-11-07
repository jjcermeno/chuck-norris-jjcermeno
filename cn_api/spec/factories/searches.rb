FactoryBot.define do
  factory :search do
    id { Faker::Number.within(range: 1..10000000) }
    search_type { ["word", "category", "random"].sample }
    search_value { Faker::Space.planet }
    email { Faker::Internet.email }
    after(:create) do |search|
      create_list :joke, (1..5).to_a.sample, searches: [search]
    end
    # jokes { create_list(:joke, (1..5).to_a.sample) }
    factory :search_with_email do
      after(:create) do |search|
        search.id = 5000
      end
    end
    factory :search_with_no_email do
      after(:create) do |search|
        search.id = 6000
        search.email = nil
      end
    end
  end

end
