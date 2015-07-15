$LOAD_PATH << '.'

$LOAD_PATH << 'lib/'

require 'bundler'
Bundler.require

class App
	class << self
		attr_accessor :env
	end
end

App.env = ENV['APP_ENV'] || 'development'

# load all models
# Dir['app/models/*.rb'].each {|name| require name}
#{@include_pg ? "\nActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))[App.env])" : ''}
