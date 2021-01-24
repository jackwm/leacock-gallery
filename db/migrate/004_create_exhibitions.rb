migration 4, :create_exhibitions do
  up do
    create_table :exhibitions do
      column :id, Integer, :serial => true
      column :created_at, DateTime
      column :updated_at, DateTime

      column :title, String, :length => 500
      column :details, Text
      column :slug, Slug, :length => 2000
      column :start_date, Date
      column :end_date, Date
    end
  end

  down do
    drop_table :exhibitions
  end
end
