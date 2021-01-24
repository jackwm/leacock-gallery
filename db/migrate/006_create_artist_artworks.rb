migration 6, :create_artist_artworks do
  up do
    create_table :artist_artworks do
      column :artist_id, Integer, :key => true
      column :artwork_id, Integer, :key => true
    end
  end

  down do
    drop_table :artist_artworks
  end
end
