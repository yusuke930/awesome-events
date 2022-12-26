FactoryBot.define do
  factory :event do
    owner # factoryで:userのaliasとして:ownerを設定しているので、owner_idとして設定される
    sequence(:name) { "Event Name#{_1}" }
    sequence(:place) { "Event Place#{_1}" }
    sequence(:content) { "Event Content#{_1}" }
    start_at { rand(1..30).days.from_now }
    end_at { start_at + rand(1..30).hours }
  end
end