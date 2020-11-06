FactoryBot.define do
  factory :category do
    id { Faker::Number.within(range: 1..10000) }
    category_name { "#{Faker::Space.planet}-#{Faker::Internet.uuid}" }
    jokes { create_list(:joke, 1) }
  end
end
