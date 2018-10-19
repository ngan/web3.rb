require "web3/types/abstract"

module Web3
  module Types
    class Filter < Abstract
      def filter(value)
        if value[:from_block]
          value[:fromBlock] = value.delete(:from_block)
        end

        if value[:to_block]
          value[:toBlock] = value.delete(:to_block)
        end

        value
      end
    end
  end
end
