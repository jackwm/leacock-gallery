namespace :assets do
  desc "set up the buckets"
  task :buckets do
    LeacockGallery.configure_buckets!
  end

  desc "empty the cache bucket"
  task :uncache do
    LeacockGallery.empty_asset_cache!
  end

  desc "sync the database with the S3 cache bucket"
  task :sync do
    LeacockGallery.gc_asset_cache!
    Image.pull
  end
end
