require "web3/types/abstract"

module Web3
  module Types
    class Boolean < Abstract
      def filter(value)
        return value if value.is_a?(TrueClass) || value.is_a?(FalseClass)

        warn_coercion!

        if ["0", 0, "false"].include?(value)
          false
        else
          !!value
        end
      end
    end
  end
end
