require "web3/types/abstract"

module Web3
  module Types
    class Integer < Abstract
      def filter(value)
        return value if value.is_a?(Integer)

        warn_coercion!

        if value.is_a?(String) && value.match?(/0x[a-f0-9]+/)
          value.to_i(16)
        else
          value.to_i
        end
      end
    end
  end
end
