case Padrino.env
  when :development
    DataMapper.setup(:default,
                     'sqlite3://' + Padrino.root('db', 'development.db'))
  when :production
    DataMapper.setup(:default,
                     ENV['DATABASE_URL'])
  when :test
    DataMapper.setup(:default,
                     'sqlite3://' + Padrino.root('db', 'test.db'))
end
