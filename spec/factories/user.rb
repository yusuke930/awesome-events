FactoryBot.define do
  factory :user, aliases: [:owner] do
    provider { "github" }
    name { Faker::Lorem.characters(number: 5) }
    sequence(:uid) { "uid#{_1}" }
    sequence(:image_url) { |i| "http://example.com/image#{i}.jpg" }
  end
end
