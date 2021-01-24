require 'securerandom'

FactoryGirl.define do
  factory :exhibition do
    title { Piffle.exhibition_title }
    details { Piffle.paragraph }
    created_at { DateTime.now }
    updated_at { DateTime.now }
    start_date { DateTime.now + (rand(2) - 1) * rand(1000) }
    end_date { start_date + rand(60) }
    slug { 'exhibition-' + SecureRandom.uuid }
    location { Piffle.address }

    trait :future do
      start_date { DateTime.now + rand(1000) }
    end

    trait :past do
      start_date { DateTime.now - rand(1000) }
    end

    trait :ongoing do
      start_date { DateTime.now - rand(30) }
      end_date { DateTime.now + rand(30) }
    end

    ignore do
      artist_count { 1 + rand(5) }
    end

    # after_create do |exhib, evaler|
    #   evaler.artist_count.times do
    #     artist = FactoryGirl.create(:artist)
    #     artist.save!
    #     link = ArtistExhibition.create(artist: artist, exhibition: exhib)
    #     link.save!
    #   end
    # end
  end
end
