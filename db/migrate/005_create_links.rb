migration 5, :create_links do
  up do
    create_table :links do
      column :id, Integer, :serial => true
      column :created_at, DateTime
      column :updated_at, DateTime

      column :url, String, :length => 255
      column :title, String, :length => 255
      column :blurb, Text
    end
  end

  down do
    drop_table :links
  end
end
