class RouteGenerator
  # Defines a method on the specified class that facilitates an API call.
  def self.generate(klass, route)
    klass.define_method(route[:name]) do |opts|
      # Generate the URL path after ensuring we have the necessary parameters.
      path = route[:url]
      (route[:required_params] || []).each do |param|
        unless opts[param]
          raise ArgumentError, "Parameter '#{param}' is needed to make this request."
        end
        path.gsub!("{{#{param}}}", opts[param])
      end
      opts = opts.except(route[:required_params].keys)
      url = ROOT_URL + path

      # Options for handling the request.
      client_options = {
        list: route[:list],
        paging: route[:paging],
        response_model: route[:response_model],
      }
      if route[:paging] && opts[:limit]
        client_options[:limit] = opts[:limit]
        opts.delete(:limit)
      end

      # Disallow extraneous parameters.
      extra_parameters = opts.keys - route[:optional_params]
      if extra_parameters.any?
        raise ArgumentError, "Exclude the following extra parameter(s): #{extra_parameters.join(', ')}"
      end

      # Make the request and return the result.
      client.send(route[:method].downcase, ROOT_URL + path, client_options, request_params)
    end
  end
end
