migration 7, :create_artist_exhibitions do
  up do
    create_table :artist_exhibitions do
      column :artist_id, Integer, :key => true
      column :exhibition_id, Integer, :key => true
    end
  end

  down do
    drop_table :artist_exhibitions
  end
end
