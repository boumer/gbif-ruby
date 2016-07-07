require 'rest-client'

module GBIF
  VERSION = '1.0.pre'

  attr_reader :client

  def initialize(username, password)
    @client = GBIF::Client.new(username, password)
  end
end
