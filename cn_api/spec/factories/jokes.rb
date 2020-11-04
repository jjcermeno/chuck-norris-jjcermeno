FactoryBot.define do
  factory :joke do
    joke_value  { Faker::ChuckNorris.fact }
    joke_url    { Faker::Internet.url }
    icon_url    { Faker::Internet.url }
    ext_id      { Faker::Internet.uuid }
  end
end