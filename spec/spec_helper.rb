PADRINO_ENV ||= 'test'
require 'bundler/setup'
require 'rack/test'
require 'ostruct'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
