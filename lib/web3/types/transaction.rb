require "web3/types/abstract"

module Web3
  module Types
    class Transaction < Abstract
      def filter(value)
        if value[:gas_price]
          value[:gasPrice] = value.delete(:gas_price)
        end

        value
      end
    end
  end
end
