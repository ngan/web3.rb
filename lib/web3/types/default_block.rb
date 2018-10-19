require "web3/types/abstract"

module Web3
  module Types
    class DefaultBlock < Abstract
      TAGS = [
        "latest",
        "earliest",
        "pending"
      ].freeze

      def filter(value)
        return value if (value.is_a?(Integer) && value >= 0) || TAGS.include?(value)

        raise "Invalid default block"
      end
    end
  end
end
