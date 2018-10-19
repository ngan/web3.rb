require "web3/types/abstract"

module Web3
  module Types
    class String < Abstract
      def filter(value)
        return value if value.is_a?(String)

        warn_coercion!
        
        value.to_s
      end
    end
  end
end
