FactoryBot.define do
  factory :category do
    category_name { Faker::Space.planet }
    jokes { create_list(:joke, 1) }
  end
end
