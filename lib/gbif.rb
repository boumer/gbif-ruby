require 'json'
require 'rest-client'

module GBIF
  require_relative 'gbif/models'
  require_relative 'gbif/client'
  require_relative 'gbif/route_generator'
  require_relative 'gbif/species'

  VERSION = '1.0.pre'
  API_VERSION = 'v1'
  ROOT_URL = "api.gbif.org/#{API_VERSION}"

  class << self
    attr_accessor :username, :password
  end
end
