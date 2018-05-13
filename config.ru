require "sinatra"
require "sinatra/reloader" if development?
require "pg"
require_relative "models/country.rb"
require_relative "controllers/country_controller.rb"

use Rack::MethodOverride

run CountryController
