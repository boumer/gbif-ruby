require 'json'
require 'rest-client'

class GBIF::Client
  attr_reader :raw_response

  RESULTS_PER_PAGE = 1000 # Arbitrary and should be benchmarked against the API.
  FORCE_READ_ONLY = true # Client is restricted to GET API calls.

  def initialize
    @raw_response = nil # Allows access to the most recent response for development/debugging.
  end

  def get(url, options, request_params = {})
    if options[:paging] && options[:limit]
      # If requested record limit exceeds our max results per page, we'll
      # request the pages separately and combine the results.
      request_params.merge(limit: [options[:limit], RESULTS_PER_PAGE].min)
    ends

    puts "[#{DateTime.now}] GET request to #{url}..."
    @raw_response = RestClient.get(url, params: request_params)
    parsed_response = JSON.parse(@raw_response)

    # Symbolize and snake-case top-level hash keys.
    if parsed_response.is_a?(Hash)
      keys = parsed_response.keys.map { |k| underscore(k).to_sym }
      Hash[keys.zip(parsed_response.values)]
    else
      parsed_response
    end
  end

  def post(url, options, request_params)
    check_credentials
    puts "[#{DateTime.now}] POST request to #{url}..."
  end

  def put(url, options, request_params)
    check_credentials
    puts "[#{DateTime.now}] PUT request to #{url}..."
  end

  def delete(url, options, request_params)
    check_credentials
    puts "[#{DateTime.now}] DELETE request to #{url}..."
  end

  # Courtesy of Rails' ActiveSupport (http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html).
  def underscore(camel_cased_word)
    return camel_cased_word unless camel_cased_word =~ /[A-Z-]|::/
    word = camel_cased_word.to_s.gsub('::'.freeze, '/'.freeze)
    word.gsub!(/(?:(?<=([A-Za-z\d]))|\b)((?-mix:(?=a)b))(?=\b|[^a-z])/) { "#{$1 && '_'.freeze }#{$2.downcase}" }
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2'.freeze)
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2'.freeze)
    word.tr!("-".freeze, "_".freeze)
    word.downcase!
    word
  end

  def check_credentials
    unless has_credentials?
      raise ArgumentError, 'A username and password are required to authenticate this request'
    end
  end

  def has_credentials?
    !!(GBIF.username && GBIF.password)
  end
end
