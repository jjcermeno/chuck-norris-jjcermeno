FactoryBot.define do
  factory :category do
    category_name { Faker::Space.planet }
    # joke_categories { create_list(:joke_category, 5) }
    jokes { create_list(:joke, 1) }
  end
end
