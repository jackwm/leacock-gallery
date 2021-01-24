require 'securerandom'

FactoryGirl.define do
  factory :artist do
    name { Piffle.name }
    created_at { DateTime.now }
    updated_at { DateTime.now }
    biography { Piffle.paragraph }
    slug { 'artist-' + SecureRandom.uuid }

    ignore do
      artwork_count { 1 + rand(5) }
    end

    # after_create do |artist, evaler|
    #   evaler.artwork_count.times do
    #     work = FactoryGirl.create(:artwork, :dimensions)
    #     work.save!
    #     link = ArtistArtwork.create(artist: artist, artwork: work)
    #     link.save!
    #   end
    # end
  end
end
