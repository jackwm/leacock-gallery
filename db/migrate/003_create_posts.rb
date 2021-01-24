migration 3, :create_posts do
  up do
    create_table :posts do
      column :id, Integer, :serial => true
      column :created_at, DateTime
      column :updated_at, DateTime

      column :title, String, :length => 500
      column :content, Text
      column :slug, Slug, :length => 2000
    end
  end

  down do
    drop_table :posts
  end
end
