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
      id { 5000 }
      search_type { ["word", "category", "random"].sample }
      search_value { Faker::Space.planet }
      email { Faker::Internet.email }
      # jokes { create_list(:joke, (1..5).to_a.sample) }
    end
    factory :search_with_no_email do
      id { 6000 }
      search_type { ["word", "category", "random"].sample }
      search_value { Faker::Space.planet }
      email { nil }
      # jokes { create_list(:joke, (1..5).to_a.sample) }
    end
  end

end


# FactoryBot.define do
#   factory :account do
#     sequence(:name) { Faker::Name.name }
#     kind { 'demo' }
#     category { 'personal' }
#
#     factory :account_with_transactions do
#       after(:create) do |account|
#         create_list :deposit, 2, account: account
#         create_list :withdrawal, 2, account: account
#       end
#     end
#
#     factory :account_with_user do
#       after(:create) do |account|
#         account.users = build_list(:user, 1)
#       end
#     end
#   end
# end