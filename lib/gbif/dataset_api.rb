class GBIF::DatasetAPI
  API_ROUTES = [
    # INDEX:
    ##########
    # Lists all datasets.
    {
      name: 'index', url: '/dataset', method: 'GET',
      response_model: GBIF::Dataset, list: true, paging: true,
      optional_params: [:q, :country, :type, :identifier, :identifier_type],
    },

    # CREATE:
    ##########
    # Creates a new dataset.
    {
      name: 'create', url: '/dataset', method: 'POST',
      response_model: GBIF::DatasetKey, list: false, paging: false,
    },

    # FIND:
    ##########
    # Gets details for the single dataset.
    {
      name: 'get', url: '/dataset/{{dataset_key}}', method: 'GET',
      response_model: GBIF::Dataset, list: false, paging: false,
      required_params: [:dataset_key],
    },

    # UPDATE:
    ##########
    # Updates the dataset.
    {
      name: 'update', url: '/dataset/{{dataset_key}}', method: 'PUT',
      response_model: nil, list: false, paging: false,
      required_params: [:dataset_key],
    },

    # DELETE:
    ##########
    # Deletes the dataset. The dataset entry gets a deleted timestamp
    # but remains registered.
    {
      name: 'delete', url: '/dataset/{{dataset_key}}', method: 'DELETE',
      response_model: nil, list: false, paging: false,
      required_params: [:dataset_key],
    },

    # CONTACTS:
    ##########
    # Lists all contacts for the dataset.
    {
      name: 'contacts', url: '/dataset/{{dataset_key}}/contact', method: 'GET',
      response_model: GBIF::Contact, list: true, paging: false,
      required_params: [:dataset_key],
    },

    # CREATE CONTACT:
    ##########
    # Create and add a dataset contact.
    {
      name: 'create_contact', url: '/dataset/{{dataset_key}}/contact', method: 'POST',
      response_model: GBIF::ContactID, list: false, paging: false,
      required_params: [:dataset_key],
    },

    #
end
