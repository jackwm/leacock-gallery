migration 2, :create_artists do
  up do
    create_table :artists do
      column :id, Integer, :serial => true
      column :created_at, DateTime
      column :updated_at, DateTime

      column :name, String, :length => 500
      column :slug, Slug, :length => 2000
      column :biography, Text
    end
  end

  down do
    drop_table :artists
  end
end
