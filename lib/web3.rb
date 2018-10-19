require "web3/version"
require "web3/instance"
require "web3/providers"

module Web3
  extend Providers

  def self.new(provider)
    Instance.new(provider)
  end
end
