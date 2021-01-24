PADRINO_ENV  = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development"
PADRINO_ROOT = File.expand_path('../..', __FILE__)

require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)

Padrino::Logger::Config[:development] = {
  log_level: :devel,
  stream: :stderr,
  format_message: "%s - %s %s"
}

Padrino.before_load do
  Dir.glob(Padrino.root('config/init/*.rb')).each { |rb| require rb }
end

Padrino.after_load do
  Grisaille.finalise!
end

Padrino.load!
