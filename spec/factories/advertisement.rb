FactoryBot.define do
  factory :advertisement do
    ad_type { Advertisement::TYPES.sample }
    title { Faker::Lorem.sentence }
    location { Faker::Address.full_address }
    description { Faker::Lorem.paragraph_by_chars(1500) }
    price { rand(1..1000).to_f }
    author_name { Faker::Name.name }
    sequence(:author_email) { |n| "author#{n}@example.org" }
    author_phone { '900 100 900' }
    terms_of_service { true }
  end
end
