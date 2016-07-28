class GBIF::SpeciesAPI
  API_ROUTES = [
    # INDEX:
    ##########
    # Lists name usages across all or some checklists that share the exact same
    # canonical name, i.e. without authorship.
    {
      name: 'index', url: '/species', method: 'GET',
      response_model: GBIF::NameUsage, list: true, paging: true,
      optional_params: [:language, :dataset_key, :source_id],
    },

    # MATCH:
    #########
    # Fuzzy matches scientific names against the GBIF Backbone Taxonomy with the
    # optional classification provided. If a classification is provided and strict
    # is not set to true, the default matching will also try to match against these
    # if no direct match is found for the name parameter alone.
    {
      name: 'match', url: '/species/match', method: 'GET',
      response_model: GBIF::NameUsage, list: true, paging: false,
      optional_params: [:rank, :name, :strict, :verbose, :kingdom, :phylum, :class, :order, :family, :genus],
    },

    # SEARCH:
    ##########
    # Full text search of name usages covering the scientific and vernacular name,
    # the species description, distribution and the entire classification across all
    # name usages of all or some checklists. Results are ordered by relevance as this
    # search usually returns a lot of results.
    {
      name: 'search', url: '/species/search', method: 'GET',
      response_model: GBIF::NameUsage, list: true, paging: true,
      optional_params: [
        :q, :dataset_key, :rank, :highertaxon_key, :status, :is_extinct,
        :habitat, :threat, :name_type, :nomenclatural_status, :issue,
        :hl, :facet, :facet_mincount, :facet_multiselect
      ],
    },

    # SUGGEST:
    ##########
    # A quick and simple autocomplete service that returns up to 20 name usages
    # by doing prefix matching against the scientific name. Results are ordered by relevance.
    {
      name: 'suggest', url: '/species/suggest', method: 'GET',
      response_model: GBIF::NameUsage, list: true, paging: false,
      optional_params: [:q, :dataset_key, :rank],
    },

    # ROOT USAGES:
    ##########
    # Lists root usages of a checklist.
    {
      name: 'root_usages', url: '/species/root/{{dataset_key}}', method: 'GET',
      response_model: GBIF::NameUsage, list: true, paging: true,
      required_params: [:dataset_key],
    },

    # FIND:
    ##########
    # Gets the single name usage.
    {
      name: 'find', url: '/species/{{name_usage_key}}', method: 'GET',
      response_model: GBIF::NameUsage, list: false, paging: false,
      required_params: [:name_usage_key],
      optional_params: [:language],
    },

    # VERBATIM:
    ##########
    # Gets the verbatim name usage.
    {
      name: 'verbatim', url: '/species/{{name_usage_key}}', method: 'GET',
      response_model: GBIF::VerbatimNameUsage, list: false, paging: false,
      required_params: [:name_usage_key],
    },

    # NAME:
    ##########
    # Gets the parsed name for a name usage.
    {
      name: 'name', url: '/species/{{name_usage_key}}/name', method: 'GET',
      response_model: GBIF::ParsedName, list: false, paging: false,
      required_params: [:name_usage_key],
    },

    # PARENTS:
    ##########
    # Lists all parent usages for a name usage.
    {
      name: 'parents', url: '/species/{{name_usage_key}}/parents', method: 'GET',
      response_model: GBIF::NameUsage, list: true, paging: false,
      required_params: [:name_usage_key],
      optional_params: [:language],
    },

    # CHILDREN:
    ##########
    # Lists all direct child usages for a name usage.
    {
      name: 'children', url: '/species/{{name_usage_key}}/children', method: 'GET',
      response_model: GBIF::NameUsage, list: true, paging: true,
      required_params: [:name_usage_key],
      optional_params: [:language],
    },

    # RELATED:
    ##########
    # Lists all related name usages in other checklists.
    {
      name: 'related', url: '/species/{{name_usage_key}}/related', method: 'GET',
      response_model: GBIF::NameUsage, list: true, paging: false,
      required_params: [:name_usage_key],
      optional_params: [:language, :dataset_key],
    },

    # SYNONYMS:
    ##########
    # Lists all synonyms for a name usage.
    {
      name: 'synonyms', url: '/species/{{name_usage_key}}/synonyms', method: 'GET',
      response_model: GBIF::NameUsage, list: true, paging: true,
      required_params: [:name_usage_key],
      optional_params: [:language],
    },

    # COMBINATIONS:
    ##########
    # Lists all combinations that have this name usage as their basionym.
    {
      name: 'combinations', url: '/species/{{name_usage_key}}/synonyms', method: 'GET',
      response_model: GBIF::NameUsage, list: true, paging: false,
      required_params: [:name_usage_key],
    },

    # DESCRIPTIONS:
    ##########
    # Lists all descriptions for a name usage
    {
      name: 'descriptions', url: '/species/{{name_usage_key}}/descriptions', method: 'GET',
      response_model: GBIF::Description, list: true, paging: true,
      requied_params: [:name_usage_key],
    },

    # DISTRIBUTIONS:
    ##########
    # Lists all distributions for a name usage
    {
      name: 'distributions', url: '/species/{{name_usage_key}}/distributions', method: 'GET',
      response_model: GBIF::Distribution, list: true, paging: true,
      required_params: [:name_usage_key],
    },

    # MEDIA:
    ##########
    # Lists all media for a name usage.
    {
      name: 'media', url: '/species/{{name_usage_key}}/media', method: 'GET',
      response_model: GBIF::Media, list: true, paging: true,
      required_params: [:name_usage_key],
    },

    # REFERENCES:
    ##########
    # Lists all references for a name usage.
    {
      name: 'references', url: '/species/{{name_usage_key}}/references', method: 'GET',
      response_model: GBIF::Reference, list: true, paging: true,
      required_params: [:name_usage_key],
    },

    # SPECIES PROFILES:
    ##########
    # Lists all species profiles for a name usage.
    {
      name: 'species_profiles', url: '/species/{{name_usage_key}}/speciesProfiles', method: 'GET',
      response_model: GBIF::SpeciesProfile, list: true, paging: true,
      required_params: [:name_usage_key],
    },

    # VERNACULAR NAMES:
    ##########
    # Lists all vernacular names for a name usage.
    {
      name: 'vernacular_names', url: '/species/{{name_usage_key}}/vernacularNames', method: 'GET',
      response_model: GBIF::VernacularName, list: true, paging: true,
      required_params: [:name_usage_key],
    },

    # TYPE SPECIMENS:
    ##########
    # Lists all type specimens for a name usage.
    {
      name: 'type_specimens', url: '/species/{{name_usage_key}}/typeSpecimens', method: 'GET',
      response_model: GBIF::TypeSpecimen, list: true, paging: true,
      required_params: [:name_usage_key],
    },

    # Potential TODO: Support the /parser/name GET/POST routes.
  ]

  class << self
    # This generates methods for each API route, using the name
    # attribute from the constants above as the method name.
    API_ROUTES.each do |route|
      GBIF::RouteGenerator.send(:generate, self, route)
    end
  end

  def self.client
    @client ||= GBIF::Client.new
  end
end
