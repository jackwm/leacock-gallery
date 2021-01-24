migration 1, :create_artworks do
  up do
    create_table :artworks do
      column :id, Integer, :serial => true
      column :created_at, DateTime
      column :updated_at, DateTime

      column :title, String, :length => 500
      column :slug, Slug, :length => 2000

      column :media, String

      column :width, String
      column :height, String
      column :depth, String
      column :weight, String

      column :stock, Integer

      column :blurb, Text

      column :price, Integer

      column :order, Integer
    end
  end

  down do
    drop_table :artworks
  end
end
