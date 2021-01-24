source :rubygems

gem 'rake'
gem 'ruby-units', '~> 1.4.0'
gem 'thin'

# contraflows
gem 'piffle'
gem 'grisaille', '0.6.11',
  # path: '/data/repos/grisaille'
  git: 'git://github.com/contraflows/grisaille.git', tag: 'v0.6.11'
gem 'redcarpet-tags', require: false,
  git: 'git://github.com/contraflows/redcarpet-tags.git'

# assets
git 'git://github.com/contraflows/picaroon-data.git' do
  gem 'picaroon-bootstrap', '>= 0.2.0', require: false
  gem 'picaroon-font_awesome', '>= 0.0.4', require: false
  gem 'picaroon-jquery', require: false
  gem 'picaroon-jquery_ujs', require: false
  gem 'picaroon-multiselect', '>= 0.0.2', require: false

  gem 'picaroon-jquery_lightbox', '>= 0.0.3',
    require: 'picaroon/jquery_lightbox/latest'
end

# persistence
gem 'dm-aggregates', '~> 1.3.0.beta',
  git: 'git://github.com/datamapper/dm-aggregates.git'
gem 'dm-adjust', '~> 1.3.0.beta',
  git: 'git://github.com/datamapper/dm-adjust.git'
# gem 'dm-constraints', '~> 1.3.0.beta',
  # git: 'git://github.com/datamapper/dm-constraints.git'
gem 'dm-core', '~> 1.3.0.beta',
  git: 'git://github.com/datamapper/dm-core.git'
gem 'dm-do-adapter', '~> 1.3.0.beta',
  git: 'git://github.com/datamapper/dm-do-adapter.git'
gem 'dm-is-list', '~> 1.3.0.beta',
  git: 'git://github.com/datamapper/dm-is-list.git'
gem 'dm-migrations', '~> 1.3.0.beta',
  git: 'git://github.com/datamapper/dm-migrations.git'
gem 'dm-validations', '~> 1.3.0.beta',
  git: 'git://github.com/datamapper/dm-validations.git'
gem 'dm-timestamps', '~> 1.3.0.beta',
  git: 'git://github.com/datamapper/dm-timestamps.git'
gem 'dm-types', '~> 1.3.0.beta',
  git: 'git://github.com/datamapper/dm-types.git'

# local
group :development do
  gem 'dm-sqlite-adapter', '~> 1.3.0.beta',
    git: 'git://github.com/datamapper/dm-sqlite-adapter.git'
  gem 'factory_girl', '~> 2.6.0'
end

# heroku
group :production do
  gem 'dm-postgres-adapter', '~> 1.3.0.beta',
    git: 'git://github.com/datamapper/dm-postgres-adapter.git'
end

# testing
group :test do
  gem 'rspec'
  gem 'rack-test',
    require: "rack/test"
end
