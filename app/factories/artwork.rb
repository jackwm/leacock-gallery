require 'securerandom'

FactoryGirl.define do
  sequence(:title) {|n| Piffle.artwork_title }

  factory :artwork do
    title
    price { rand(200) * 1000 + rand(100) }
    stock { rand(4) }
    created_at { DateTime.now }
    updated_at { DateTime.now }
    media { Piffle.evaluate "@noun on @noun" }
    slug { 'artwork-' + SecureRandom.uuid }

    trait :dimensions do
      width { "%.2f cm" % (5 + rand * rand(300)) }
      height { "%.2f cm" % (5 + rand * rand(400)) }
      depth { "%.2f cm" % (5 + rand * rand(200)) }
    end

    trait :weight do
      weight { "%.1f g" % (50 + rand * rand(5000)) }
    end

    trait :blurb do
      blurb { Piffle.paragraph }
    end

    trait :folly do
      price { rand(100) * 100 + rand(100) }
    end

    trait :sold_out do
      stock 0
    end

    trait :single do
      stock 1
    end
  end
end
