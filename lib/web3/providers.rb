require "web3/providers/http"

module Web3
  module Providers
    def HTTP(*args)
      new(Web3::Providers::HTTP.new(*args))
    end
  end
end
