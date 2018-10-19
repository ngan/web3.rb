module Web3
  module APIs
    def api(namespace, api_class)
      api_var = "@#{namespace}".freeze

      define_method(namespace) do
        instance_variable_get(api_var) ||
          instance_variable_set(api_var, api_class.new(self))
      end
    end
  end
end
